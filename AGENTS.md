# AGENTS.md

## Project

Hugo-based personal blog at [blog.rullypratama.com](https://blog.rullypratama.com/). Custom hand-built theme (`themes/custom/`), no third-party Hugo themes. No npm build pipeline at repo root — never invent `npm`/`yarn` commands for site work (`node_modules` inside `.opencode/` is tooling-only).

## Verification

- No tests, linters, or formatters exist. Verification = `hugo build --gc --minify` completing without errors.
- Hugo v0.161.1 (extended) is pinned in `build.sh`; a matching version is installed locally.
- Dev server in this environment: `hugo server -D --bind 0.0.0.0 --renderToMemory --baseURL https://hugo.cikohome.stream` (also in gitignored `hugo-command.txt`).

## Commands

| Task | Command |
|---|---|
| Dev server | see above |
| Production build | `hugo build --gc --minify` |
| New post (ID) | `hugo new posts/my-new-post/index.md` |

- English version of a post is created manually as `index.en.md` alongside `index.md` in the same page bundle.
- `public/` is gitignored build output; `resources/_gen/` is the processed-image cache.

## Architecture

- **Content**: `content/posts/` — page bundles, bilingual (`index.md` = Indonesian, `index.en.md` = English). Default language is Indonesian (`id`).
- **Other sections**: `content/gallery/` and `content/raw-samples/` (photo gallery and RAW photo samples) — have their own layouts and archetypes; not documented in the refs below.
- **Theme**: `themes/custom/` — hand-built. Layouts in `layouts/`, static assets (CSS/JS/fonts) in `static/`. JS is three small self-contained files (`theme-toggle.js`, `gallery-lightbox.js`); no bundler.
- **Config**: `hugo.toml` — site settings, language params, permalinks (`/:year/:month/:title/`), markup (Goldmark passthrough for math, Monokai syntax highlighting, `unsafe = true`).
- **Permalinks**: `/2024/02/post-title/` format.

## Deployment

- Hosted on **Cloudflare Workers** via `wrangler.toml`.
- CI build runs `build.sh` which downloads pinned versions of Go, Hugo, Dart Sass, and Node.js into `$HOME/.local` — do not assume these are pre-installed in CI.
- Build timezone is forced to `Asia/Jakarta` (affects post dates).
- `wrangler.toml` build command: `chmod a+x build.sh && ./build.sh`
- Assets directory: `./public`

## JS Dependencies Rule

- No vendored or npm-installed JS. All client JS lives as plain files in `themes/custom/static/js/`.
- **Exception: CDN `<script>` loads are allowed for per-content opt-in features.** KaTeX is the existing precedent: loaded from jsdelivr (v0.16.11, SRI-pinned) only when a page sets front matter `math: true` (site-level `math = false` in `hugo.toml`). Bumping the KaTeX version requires updating the SRI `integrity` hashes — don't skip that.
- New opt-in features (e.g., Mermaid) should follow this same render-hook + lazy-CDN pattern.

## Mermaid Support — Implemented

Users write ```` ```mermaid ```` fenced code blocks; no front matter needed.

- `themes/custom/layouts/_default/_markup/render-codeblock-mermaid.html` — emits `<pre class="mermaid">` plus (once per page, tracked via a `Page.Store` flag) a `<script defer>` for the renderer. Empty blocks raise a build error.
- `themes/custom/static/js/mermaid-diagrams.js` — dynamic-imports Mermaid from `https://cdn.jsdelivr.net/npm/mermaid@11/...` (verified 200), initializes with `startOnLoad: false`, renders all `pre.mermaid`, and re-renders on `<html data-theme>` changes via `MutationObserver` (theme is toggled by `theme-toggle.js` switching that attribute). Original sources are stashed in `pre.dataset.mermaidSource` because `mermaid.run()` replaces the element content.
- CSS lives right after the `pre {}` block in `main.css`; `:has(svg)` switches a diagram from code-block styling to figure styling after render.
- No SRI is possible for dynamic ESM imports — the major version pin in the URL is the integrity control. If you bump the version, update `MERMAID_URL` in the JS file and re-test on `hugo server -D`.
- RSS feeds include full content, so diagram source appears as plain text there; that's by design (feed readers strip the loader script).

## Conventions

- Posts use page bundles (each post in its own directory with `index.md`).
- Front matter fields: `title`, `date`, `description`, `categories`, `keywords`, `featured`.
- Math rendering supported via Goldmark passthrough (`$$...$$` blocks, `$...$` inline) with per-page `math: true`.
- Code blocks use Monokai style, 4-space tabs.

## Content Rules

- **Images**: Never use standard Markdown `![alt](url)`. Always use `{{< img src="..." alt="..." caption="..." >}}` shortcode.
- **Animated content**: Use `{{< video src="..." alt="..." caption="..." >}}` shortcode.
- **Categories**: `Fotografi`, `Musik`, `Office`, `Random`, `Tool`, `Tutorial`, `Home Lab`.
- **Reference files**: Before writing/translating, check `.opencode/refs/` for `writing-style.md`, `blog-structure.md`, and `translation-tracker.md`.

## What NOT to Do

- No corporate/academic speak ("Furthermore", "Thus", "Moreover", "In conclusion").
- No AI filler ("In today's fast-paced digital world...").
- Do not explain Hugo basics, markdown syntax, or SSG concepts unless asked.
- Do not modify content files unless specifically asked for a technical fix.
