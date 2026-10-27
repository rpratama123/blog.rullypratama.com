#!/usr/bin/env bash
#
# llm-bench.sh - latency & throughput benchmark for an OpenAI-compatible
#                streaming endpoint (<BASE_URL>/chat/completions)
#
# Per request : TTFT, end-to-end latency, inter-token latency (ITL), decode tok/s
# Per run     : req/s, output tok/s, total tok/s, p50/p90/p99 percentiles
# Sweeps      : models x concurrency levels
#
# Requires: bash >= 5 (microsecond timer), curl, python3 (stats only)

set -uo pipefail
export LC_ALL=C

# ---------------- defaults (env or flags) ----------------
BASE_URL="${BASE_URL:-http://localhost:8000/api/v1}"
API_KEY="${API_KEY:-}"
MODELS=""
CONC_LIST="1"
NUM_REQ=20
MAX_TOKENS=256
WARMUP=1
TIMEOUT=300
PAD_WORDS=0
TEMPERATURE=0
PROMPT="Write a long, detailed story about a lighthouse keeper who discovers a mysterious radio signal. Use many paragraphs."
PROMPT_FILE=""
USE_USAGE=1
NONCE=1
OUT_CSV=""
LIST_ONLY=0

usage() { cat <<EOF
Usage: $0 [options]

  -u URL      Base URL (default: \$BASE_URL or http://localhost:8000/api/v1)
  -k KEY      API key, sent as Bearer token (default: \$API_KEY)
  -m MODELS   Comma-separated model IDs, or "all" (default: first from /models)
  -c LIST     Concurrency levels, comma-separated, e.g. 1,4,8,16 (default: 1)
  -n N        Requests per concurrency level (default: 20; raised to >= concurrency)
  -t N        max_tokens per request (default: 256)
  -p TEXT     Prompt text
  -f FILE     Read prompt from file
  -i N        Prepend ~N words of filler to the prompt (tests prefill / long input)
  -w N        Warm-up requests per model, not counted (default: 1)
  -T SEC      Per-request timeout (default: 300)
  -o FILE     Append summary rows to this CSV
  -l          List models and exit
  --no-usage  Don't send stream_options.include_usage (count stream chunks instead)
  --cache     Don't add a unique prefix per request (allows prefix-cache hits)
  -h          Help

Examples:
  $0 -u http://10.0.0.5:8000/api/v1 -m llama-3.1-8b -c 1,4,16 -n 32
  API_KEY=... $0 -m all -c 1,8 -n 16 -t 512 -i 2000 -o results.csv
EOF
}

die() { echo "ERROR: $*" >&2; exit 1; }

# ---------------- args ----------------
while (( $# )); do
  case $1 in
    -u) BASE_URL=${2:?-u needs a value}; shift 2 ;;
    -k) API_KEY=${2:?-k needs a value}; shift 2 ;;
    -m) MODELS=${2:?-m needs a value}; shift 2 ;;
    -c) CONC_LIST=${2:?-c needs a value}; shift 2 ;;
    -n) NUM_REQ=${2:?-n needs a value}; shift 2 ;;
    -t) MAX_TOKENS=${2:?-t needs a value}; shift 2 ;;
    -p) PROMPT=${2:?-p needs a value}; shift 2 ;;
    -f) PROMPT_FILE=${2:?-f needs a value}; shift 2 ;;
    -i) PAD_WORDS=${2:?-i needs a value}; shift 2 ;;
    -w) WARMUP=${2:?-w needs a value}; shift 2 ;;
    -T) TIMEOUT=${2:?-T needs a value}; shift 2 ;;
    -o) OUT_CSV=${2:?-o needs a value}; shift 2 ;;
    -l) LIST_ONLY=1; shift ;;
    --no-usage) USE_USAGE=0; shift ;;
    --cache) NONCE=0; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "unknown option: $1 (see -h)" ;;
  esac
done

# ---------------- checks ----------------
(( BASH_VERSINFO[0] >= 5 )) || die "bash >= 5 required for microsecond timing (macOS: brew install bash)"
command -v curl >/dev/null || die "curl not found"
PY=$(command -v python3 || command -v python) || die "python3 not found (needed for statistics)"
BASE_URL=${BASE_URL%/}
AUTH=()
[[ -n $API_KEY ]] && AUTH=(-H "Authorization: Bearer $API_KEY")

list_models() {
  curl -sS --max-time 30 "${AUTH[@]}" "$BASE_URL/models" | "$PY" -c '
import json, sys
try:
    d = json.load(sys.stdin)
except Exception as e:
    sys.exit(f"could not parse /models response: {e}")
items = d.get("data") or d.get("models") or [] if isinstance(d, dict) else d
for m in items:
    print(m.get("id") or m.get("name") if isinstance(m, dict) else m)'
}

if (( LIST_ONLY )); then list_models; exit; fi

# ---------------- prompt / payload ----------------
json_escape() {
  local s=$1
  s=${s//\\/\\\\}; s=${s//\"/\\\"}
  s=${s//$'\n'/\\n}; s=${s//$'\r'/\\r}; s=${s//$'\t'/\\t}
  printf '%s' "$s"
}

[[ -n $PROMPT_FILE ]] && { [[ -r $PROMPT_FILE ]] || die "cannot read $PROMPT_FILE"; PROMPT=$(<"$PROMPT_FILE"); }
if (( PAD_WORDS > 0 )); then
  filler="" s="The quick brown fox jumps over the lazy dog near the quiet river bank. "  # 14 words
  for (( i = 0; i < PAD_WORDS; i += 14 )); do filler+=$s; done
  PROMPT="Background text (ignore it): ${filler}"$'\n\n'"$PROMPT"
fi
PROMPT_ESC=$(json_escape "$PROMPT")
STREAM_OPTS=""
(( USE_USAGE )) && STREAM_OPTS=',"stream_options":{"include_usage":true}'

make_payload() {  # <file> <request-id>
  local prefix=""
  (( NONCE )) && prefix="[req ${EPOCHREALTIME/[.,]/}-$2] "
  printf '{"model":"%s","messages":[{"role":"user","content":"%s%s"}],"max_tokens":%d,"temperature":%s,"stream":true%s}' \
    "$MODEL_ESC" "$prefix" "$PROMPT_ESC" "$MAX_TOKENS" "$TEMPERATURE" "$STREAM_OPTS" > "$1"
}

# ---------------- one streaming request ----------------
# Output (TSV): id ok http ttft_us e2e_us gen_us out_tok in_tok chunks usage_flag error
RE_CONTENT='"(content|reasoning_content|reasoning)":[[:space:]]*"[^"]'
RE_OUT='"completion_tokens":[[:space:]]*([0-9]+)'
RE_IN='"prompt_tokens":[[:space:]]*([0-9]+)'

run_one() {
  local id=$1 pf="$TMPD/p_$1.json"
  local line t0 t_end t_first=0 t_last=0 http=000 out=0 inp=0 chunks=0 usage=0 cerr=0 err=""
  make_payload "$pf" "$id"
  t0=${EPOCHREALTIME/[.,]/}
  while IFS= read -r line || [[ -n $line ]]; do
    line=${line%$'\r'}
    case $line in
      data:*)
        if [[ $line =~ $RE_CONTENT ]]; then
          t_last=${EPOCHREALTIME/[.,]/}
          (( t_first )) || t_first=$t_last
          chunks=$(( chunks + 1 ))
        fi
        [[ $line =~ $RE_OUT ]] && { out=${BASH_REMATCH[1]}; usage=1; }
        [[ $line =~ $RE_IN ]] && inp=${BASH_REMATCH[1]}
        [[ -z $err && $line == *'"error"'* ]] && err=${line:5:200}
        ;;
      __HTTP__:*) http=${line#__HTTP__:} ;;
      curl:*) cerr=1; err=${line:0:200} ;;
      ''|:*|event:*|id:*|retry:*) ;;
      *) [[ -z $err ]] && err=${line:0:200} ;;
    esac
  done < <(curl -sS -N --max-time "$TIMEOUT" -X POST "$BASE_URL/chat/completions" \
             -H 'Content-Type: application/json' -H 'Accept: text/event-stream' \
             "${AUTH[@]}" --data-binary "@$pf" -w '\n__HTTP__:%{http_code}\n' 2>&1)
  t_end=${EPOCHREALTIME/[.,]/}
  rm -f "$pf"

  (( usage )) || out=$chunks
  local ok=0 ttft=0 gen=0
  if [[ $http == 200 ]] && (( chunks > 0 && ! cerr )); then
    ok=1; ttft=$(( t_first - t0 )); gen=$(( t_last - t_first ))
  fi
  (( ok )) || [[ -n $err ]] || err="no tokens received"
  err=${err//$'\t'/ }
  printf '%s\t%d\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\n' \
    "$id" "$ok" "$http" "$ttft" "$(( t_end - t0 ))" "$gen" "$out" "$inp" "$chunks" "$usage" "$err"
}

worker() {  # <worker-index> <concurrency> <total-requests>
  local w=$1 c=$2 n=$3 i
  for (( i = w; i < n; i += c )); do run_one "$i" >> "$TMPD/w$w.tsv"; done
}

# ---------------- stats (python) ----------------
TMPD=$(mktemp -d)
trap 'rm -rf "$TMPD"' EXIT
trap 'trap - INT TERM; echo " interrupted"; kill 0' INT TERM
SESSION_CSV="$TMPD/session.csv"

cat > "$TMPD/stats.py" <<'PYEOF'
import sys, csv, os, time, math
from collections import Counter

FIELDS = ["timestamp","model","concurrency","requests","ok","failed","wall_s",
          "req_per_s","out_tok_per_s","total_tok_per_s",
          "ttft_p50_ms","ttft_p90_ms","ttft_p99_ms","e2e_p50_ms","e2e_p90_ms",
          "itl_p50_ms","decode_tps_p50","avg_in_tok","avg_out_tok","token_source"]

def pct(v, p):
    if not v: return math.nan
    v = sorted(v); k = (len(v) - 1) * p / 100.0; f = int(k); c = min(f + 1, len(v) - 1)
    return v[f] + (v[c] - v[f]) * (k - f)

def mean(v): return sum(v) / len(v) if v else math.nan
def isnan(x): return isinstance(x, float) and math.isnan(x)
def fmt(x, d=1): return "-" if isnan(x) else f"{x:,.{d}f}"
def r(x, d=1): return "" if isnan(x) else round(x, d)

def run(tsv, wall_us, model, conc, session_csv):
    wall = max(int(wall_us) / 1e6, 1e-9)
    rows = [l.rstrip("\n").split("\t") for l in open(tsv) if l.strip()]
    rows = [p for p in rows if len(p) >= 10]
    ok  = [p for p in rows if p[1] == "1"]
    bad = [p for p in rows if p[1] != "1"]
    ttft = [int(p[3]) / 1e3 for p in ok]
    e2e  = [int(p[4]) / 1e3 for p in ok]
    out  = [int(p[6]) for p in ok]
    inp  = [int(p[7]) for p in ok]
    itl, dec = [], []
    for p in ok:
        g, n = int(p[5]), int(p[6])
        if n > 1 and g > 0:
            itl.append(g / 1e3 / (n - 1)); dec.append((n - 1) / (g / 1e6))
    src = "-" if not ok else ("usage" if all(p[9] == "1" for p in ok) else "chunks(approx)")

    print(f"\n  {model} | concurrency {conc} | {len(ok)} ok / {len(bad)} failed | wall {wall:.2f}s")
    print(f"  Throughput: {fmt(len(ok)/wall, 2)} req/s | output {fmt(sum(out)/wall)} tok/s"
          f" | total (in+out) {fmt((sum(out)+sum(inp))/wall)} tok/s | token count: {src}")
    print(f"  {'metric':<22}" + "".join(f"{h:>10}" for h in ("mean","p50","p90","p99","min","max")))
    for name, v in [("TTFT (ms)", ttft), ("E2E latency (ms)", e2e), ("ITL (ms/token)", itl),
                    ("Decode (tok/s/req)", dec), ("Output tokens", out), ("Input tokens", inp)]:
        stats = (mean(v), pct(v, 50), pct(v, 90), pct(v, 99),
                 min(v) if v else math.nan, max(v) if v else math.nan)
        print(f"  {name:<22}" + "".join(f"{fmt(x):>10}" for x in stats))
    for (code, e), k in Counter((p[2], p[10] if len(p) > 10 else "") for p in bad).most_common(3):
        print(f"  ! {k}x HTTP {code}: {e[:160]}")

    row = dict(timestamp=time.strftime("%Y-%m-%dT%H:%M:%S"), model=model, concurrency=conc,
               requests=len(rows), ok=len(ok), failed=len(bad), wall_s=round(wall, 3),
               req_per_s=round(len(ok)/wall, 3), out_tok_per_s=round(sum(out)/wall, 1),
               total_tok_per_s=round((sum(out)+sum(inp))/wall, 1),
               ttft_p50_ms=r(pct(ttft, 50)), ttft_p90_ms=r(pct(ttft, 90)), ttft_p99_ms=r(pct(ttft, 99)),
               e2e_p50_ms=r(pct(e2e, 50)), e2e_p90_ms=r(pct(e2e, 90)),
               itl_p50_ms=r(pct(itl, 50), 2), decode_tps_p50=r(pct(dec, 50)),
               avg_in_tok=r(mean(inp)), avg_out_tok=r(mean(out)), token_source=src)
    new = not os.path.exists(session_csv)
    with open(session_csv, "a", newline="") as fh:
        w = csv.DictWriter(fh, FIELDS)
        if new: w.writeheader()
        w.writerow(row)

def final(session_csv, out_csv=""):
    if not os.path.exists(session_csv):
        print("\nNo results."); return
    rows = list(csv.DictReader(open(session_csv)))
    cols = [("model","model"),("concurrency","conc"),("ok","ok"),("failed","fail"),
            ("req_per_s","req/s"),("out_tok_per_s","out tok/s"),("total_tok_per_s","tot tok/s"),
            ("ttft_p50_ms","TTFT p50"),("ttft_p90_ms","TTFT p90"),("itl_p50_ms","ITL p50"),
            ("decode_tps_p50","tok/s/req"),("e2e_p50_ms","E2E p50")]
    wid = [max(len(h), *(len(str(x[k])) for x in rows)) for k, h in cols]
    line = lambda vals: "  ".join(v.ljust(w) if i == 0 else v.rjust(w) for i, (v, w) in enumerate(zip(vals, wid)))
    print("\n=== Summary (latencies in ms) ===")
    print(line([h for _, h in cols]))
    print(line(["-" * w for w in wid]))
    for x in rows: print(line([str(x[k]) for k, _ in cols]))
    if out_csv:
        new = not os.path.exists(out_csv) or os.path.getsize(out_csv) == 0
        with open(out_csv, "a", newline="") as fh:
            w = csv.DictWriter(fh, FIELDS)
            if new: w.writeheader()
            w.writerows(rows)
        print(f"\nAppended {len(rows)} row(s) to {out_csv}")

if sys.argv[1] == "run": run(*sys.argv[2:7])
else: final(*sys.argv[2:4])
PYEOF

# ---------------- model / concurrency lists ----------------
if [[ -z $MODELS ]]; then
  MODELS=$(list_models | head -n1)
  [[ -n $MODELS ]] || die "no model given (-m) and none found at $BASE_URL/models"
  echo "No -m given; using first model from /models: $MODELS"
fi
if [[ $MODELS == all ]]; then
  mapfile -t MODEL_ARR < <(list_models)
  (( ${#MODEL_ARR[@]} )) || die "no models found at $BASE_URL/models"
else
  IFS=, read -r -a MODEL_ARR <<< "$MODELS"
fi
IFS=, read -r -a CONC_ARR <<< "$CONC_LIST"

echo "Endpoint : $BASE_URL/chat/completions"
echo "Models   : ${MODEL_ARR[*]}"
echo "Conc     : ${CONC_ARR[*]} | requests/level: $NUM_REQ | max_tokens: $MAX_TOKENS | prompt ~$(wc -w <<< "$PROMPT") words"
echo "Options  : usage=$USE_USAGE unique-prefix=$NONCE warmup=$WARMUP timeout=${TIMEOUT}s"

# ---------------- main loop ----------------
for model in "${MODEL_ARR[@]}"; do
  MODEL_ESC=$(json_escape "$model")
  echo; echo "=== $model ==="

  if (( WARMUP > 0 )); then
    warm_ok=0
    for (( i = 0; i < WARMUP; i++ )); do
      IFS=$'\t' read -r -a f <<< "$(run_one "warm$i")"
      if [[ ${f[1]} == 1 ]]; then warm_ok=1
      else echo "  warm-up failed: HTTP ${f[2]} ${f[10]:-}"; fi
    done
    (( warm_ok )) || { echo "  skipping $model (warm-up never succeeded)"; continue; }
  fi

  for c in "${CONC_ARR[@]}"; do
    n=$NUM_REQ; (( n < c )) && n=$c
    rm -f "$TMPD"/w*.tsv
    echo "  running: concurrency=$c requests=$n ..."
    t0=${EPOCHREALTIME/[.,]/}
    for (( w = 0; w < c; w++ )); do worker "$w" "$c" "$n" & done
    wait
    t1=${EPOCHREALTIME/[.,]/}
    cat "$TMPD"/w*.tsv > "$TMPD/run.tsv" 2>/dev/null
    "$PY" "$TMPD/stats.py" run "$TMPD/run.tsv" "$(( t1 - t0 ))" "$model" "$c" "$SESSION_CSV"
  done
done

"$PY" "$TMPD/stats.py" final "$SESSION_CSV" "$OUT_CSV"
