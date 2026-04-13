# AGENTS.md

## Project

Hugo-based personal blog at [blog.rullypratama.com](https://blog.rullypratama.com/). Custom theme, no third-party Hugo themes or JS frameworks.

## Commands

| Task | Command |
|---|---|
| Local dev server | `hugo server -D` |
| Production build | `hugo build --gc --minify` |
| New post (ID) | `hugo new posts/my-new-post/index.md` |

- English version of a post is created manually as `index.en.md` alongside `index.md` in the same page bundle.
- `public/` is gitignored build output.

## Architecture

- **Content**: `content/posts/` — page bundles, bilingual (`index.md` = Indonesian, `index.en.md` = English). Default language is Indonesian (`id`).
- **Theme**: `themes/custom/` — hand-built. Layouts in `layouts/`, static assets (CSS/JS/fonts) in `static/`.
- **Static assets**: `static/assets/` — favicons, images, downloadable files, resume.
- **Config**: `hugo.toml` — site settings, language params, permalinks (`/:year/:month/:title/`), markup (Goldmark passthrough for math, Monokil syntax highlighting).
- **Permalinks**: `/2024/02/post-title/` format.

## Deployment

- Hosted on **Cloudflare Workers** via `wrangler.toml`.
- CI build runs `build.sh` which downloads pinned versions of Go, Hugo, Dart Sass, and Node.js into `$HOME/.local` — do not assume these are pre-installed in CI.
- Build timezone is forced to `Asia/Jakarta` (affects post dates).
- `wrangler.toml` build command: `chmod a+x build.sh && ./build.sh`
- Assets directory: `./public`

## Conventions

- Posts use page bundles (each post in its own directory with `index.md`).
- Front matter fields: `title`, `date`, `description`, `categories`, `keywords`, `featured`.
- Math rendering supported via Goldmark passthrough (`$$...$$` blocks, `$...$` inline).
- Code blocks use Monokil style, 4-space tabs.
- No third-party JS dependencies — theme is fully self-contained.

## Content Rules

- **Images**: Never use standard Markdown `![alt](url)`. Always use `{{< img src="..." alt="..." caption="..." >}}` shortcode.
- **Animated content**: Use `{{< video src="..." alt="..." caption="..." >}}` shortcode.
- **Categories**: `Fotografi`, `Musik`, `Office`, `Random`, `Tool`, `Tutorial`.
- **Reference files**: Before writing/translating, check `.opencode/refs/` for `writing-style.md`, `blog-structure.md`, and `translation-tracker.md`.

## What NOT to Do

- No corporate/academic speak ("Furthermore", "Thus", "Moreover", "In conclusion").
- No AI filler ("In today's fast-paced digital world...").
- Do not explain Hugo basics, markdown syntax, or SSG concepts unless asked.
- Do not modify content files unless specifically asked for a technical fix.
