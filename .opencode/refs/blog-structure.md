# Blog Structure Guide for Karen

## Hugo Configuration Summary

| Setting | Value |
|---|---|
| **Base URL** | `https://blog.rullypratama.com/` |
| **Title** | `Rully Pratama` |
| **Theme** | `custom` (hand-built, no third-party themes) |
| **Default Language** | `id` (Indonesian) |
| **Languages** | `id` (weight 1), `en` (weight 2) |
| **Pagination** | 20 posts per page |
| **Robots.txt** | Enabled |
| **Permalink Format** | `/:year/:month/:title/` (e.g., `/2024/02/post-title/`) |
| **Math Rendering** | Goldmark passthrough (`$$...$$` blocks, `$...$` inline) |
| **Code Highlighting** | Monokai style, 4-space tabs, no line numbers |
| **Analytics** | Umami (website ID: `3c52595d-87db-4d7e-a971-7ded29978056`) |

## Content Directory Structure

```
content/
├── _index.md              # Indonesian homepage content
├── _index.en.md           # English homepage content
└── posts/
    ├── _index.md          # Indonesian posts section index
    ├── _index.en.md       # English posts section index
    ├── 2019-12-01-city-pop/
    │   ├── index.md       # Indonesian post
    │   └── index.en.md    # English post
    ├── 2024-01-25-mini-pc-savings/
    │   ├── index.md
    │   ├── index.en.md
    │   └── mini-pc.webp   # Post-specific image asset
    └── ...
```

**Key Rules:**
- All posts live in `content/posts/` as **page bundles** (each post in its own directory).
- Post directories follow the pattern: `YYYY-MM-DD-slug/`.
- Each post contains `index.md` (Indonesian) and optionally `index.en.md` (English).
- Images and assets specific to a post are placed inside the same page bundle directory.

## Multilingual Setup

- **Default language:** Indonesian (`id`).
- **Secondary language:** English (`en`).
- **File naming:** `index.md` = Indonesian, `index.en.md` = English.
- **URL structure:** 
  - Indonesian: `https://blog.rullypratama.com/2024/02/post-title/`
  - English: `https://blog.rullypratama.com/en/2024/02/post-title/`
- **Section URLs:**
  - Indonesian: `/posts`
  - English: `/en/posts`

## Front Matter Reference

All posts use YAML front matter with the following fields:

```yaml
---
title: "Post Title Here"
date: "2024-01-25"
description: "A brief description of the post for SEO and listing pages."
categories:
  - "Category Name"
keywords:
  - "keyword1"
  - "keyword2"
featured: false
---
```

| Field | Type | Required | Description |
|---|---|---|---|
| `title` | string | Yes | Post title, always in double quotes. |
| `date` | string | Yes | Publication date in `YYYY-MM-DD` format. |
| `description` | string | No | Short summary for SEO/meta description. |
| `categories` | list | Yes | Single category from the allowed list (see Taxonomy). |
| `keywords` | list | No | SEO keywords, lowercase. |
| `featured` | boolean | No | Marks post as featured on homepage. Default: `false`. |
| `draft` | boolean | No | If `true`, post is not published in production builds. |
| `image` | string | No | Cover image path (rarely used, mostly for external URLs). |

**Real Example:**
```yaml
---
title: "GPU Bekas Mining Tanpa Display Output, Emang Bisa Buat Nge-Game?"
date: "2023-06-09"
description: "Jadikan Nvidia P106-100, GPU bekas mining, sebagai GPU gaming murah meriah"
featured: true
categories:
  - "Tutorial"
  - "Random"
keywords:
  - "gpu"
  - "nvidia"
  - "mining gpu"
  - "nvidia P106"
  - "nvidia P106-100"
---
```

## Taxonomy Reference

### Categories (Allowed Values)

Only these categories are used. Capitalization matters — use exactly as shown:

| Category | Usage |
|---|---|
| `Fotografi` | Photography-related posts |
| `Musik` | Music-related posts |
| `Office` | Microsoft Office tips and tricks |
| `Random` | Personal thoughts, reviews, non-tutorial content |
| `Tool` | Software/tool introductions and reviews |
| `Tutorial` | Step-by-step guides and how-tos |
| `Home Lab` | Topics on home labs |

**Note:** A post can have multiple categories (e.g., `Tutorial` + `Random`).

### Keywords

- Always lowercase.
- Use natural phrases, not single words only (e.g., `"mining gpu"`, `"nvidia P106-100"`).
- Include brand names, product names, and topic descriptors.

## File Naming Conventions

| Element | Convention | Example |
|---|---|---|
| **Post directory** | `YYYY-MM-DD-slug/` (kebab-case, date-prefixed) | `2024-01-25-mini-pc-savings/` |
| **Indonesian content** | `index.md` | `content/posts/2024-01-25-mini-pc-savings/index.md` |
| **English content** | `index.en.md` | `content/posts/2024-01-25-mini-pc-savings/index.en.md` |
| **Post images** | Descriptive kebab-case, placed in page bundle | `mini-pc.webp`, `NVIDIA-P106-100.webp` |
| **Static assets** | `static/assets/` for site-wide files | `static/assets/resume/resume.html` |

## Custom Shortcodes Reference

### `img` — Responsive Image with Caption

```
{{< img src="filename.webp" width="800" alt="Alt text" caption="Caption text" >}}
```

| Parameter | Required | Description |
|---|---|---|
| `src` | Yes | Image filename (relative to page bundle) or path. |
| `width` | No | Display width in pixels. Default: `800`. |
| `alt` | No | Alt text for accessibility. |
| `caption` | No | Caption displayed below the image. |

**Rules:**
- **NEVER** use standard Markdown `![alt](url)` for images.
- Always use `{{< img >}}` shortcode.
- Images should be in WebP format when possible.

### `video` — Embedded Video for Animated Content

```
{{< video src="filename.mp4" alt="Alt text" caption="Caption text" >}}
```

| Parameter | Required | Description |
|---|---|---|
| `src` | Yes | Video filename (relative to page bundle). |
| `alt` | No | Alt text for accessibility. |
| `caption` | No | Caption displayed below the video. |

**Rules:**
- Use for animated content (GIFs, screen recordings, etc.).
- Supports MP4/WebM formats.

## Archetype Templates

Two archetype templates exist in `archetypes/`:

### `archetypes/posts.md` (Indonesian)
```yaml
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: "{{ .Date }}"
description: ""
categories:
  -
keywords:
  -
featured: false
---
```

### `archetypes/posts.en.md` (English)
```yaml
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: "{{ .Date }}"
description: ""
categories:
  -
keywords:
  -
featured: false
---
```

Both templates are identical in structure. The title is auto-generated from the directory name.

## Creating a New Post — Step by Step

### 1. Create the Post Directory and Indonesian File

```bash
hugo new posts/YYYY-MM-DD-post-slug/index.md
```

This creates the directory and `index.md` using the archetype template.

### 2. Create the English File (if applicable)

```bash
hugo new posts/YYYY-MM-DD-post-slug/index.en.md
```

Or manually copy and translate the Indonesian file.

### 3. Fill in Front Matter

Edit both files and fill in:
- `title` — Post title in the respective language.
- `date` — Already auto-filled by Hugo.
- `description` — Brief summary (1-2 sentences).
- `categories` — Choose from the allowed list.
- `keywords` — Add relevant lowercase keywords.
- `featured` — Set to `true` if the post should appear on the homepage featured section.

### 4. Add Content

- Write content using Markdown.
- For images, place them in the post's page bundle directory and use `{{< img >}}` shortcode.
- For animated content, use `{{< video >}}` shortcode.
- For code blocks, use standard fenced code blocks (highlighted with Monokai style).
- For math, use `$$...$$` (block) or `$...$` (inline).

### 5. Add Post-Specific Assets

Place any images, videos, or downloadable files directly in the post's page bundle directory:
```
content/posts/YYYY-MM-DD-post-slug/
├── index.md
├── index.en.md
├── hero-image.webp
└── screenshot.webp
```

### 6. Preview Locally

```bash
hugo server -D
```

### 7. Production Build

```bash
hugo build --gc --minify
```

### 8. Deployment

- Hosted on **Cloudflare Workers** via `wrangler.toml`.
- CI build runs `build.sh` which downloads pinned versions of Go, Hugo, Dart Sass, and Node.js.
- Build timezone is forced to `Asia/Jakarta`.
- `wrangler.toml` build command: `chmod a+x build.sh && ./build.sh`
- Assets directory: `./public`