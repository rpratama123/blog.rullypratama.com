# blog.rullypratama.com

Source code for my personal blog at [blog.rullypratama.com](https://blog.rullypratama.com/). Built with [Hugo](https://gohugo.io/) using a custom theme.

## Features

- Bilingual content (Bahasa Indonesia and English)
- Custom minimal theme with no third-party dependencies
- Dark/light mode with OS preference detection
- Responsive image pipeline (WebP + JPEG srcset at multiple breakpoints)
- Self-hosted Umami analytics
- RSS feeds with full article content

## Prerequisites

- [Hugo](https://gohugo.io/installation/) v0.157.0 or later (extended edition not required)

## Local Development

```bash
hugo server -D
```

## Build

```bash
hugo
```

Output will be in the `public/` directory.

## Project Structure

```
.
├── archetypes/          # Templates for new content
├── content/
│   ├── posts/           # Blog posts (page bundles, bilingual)
│   ├── _index.md        # Homepage (ID)
│   └── _index.en.md     # Homepage (EN)
├── static/assets/       # Favicons, images, downloads, resume
├── themes/custom/       # Hand-built theme
│   ├── layouts/         # Hugo templates and shortcodes
│   └── static/          # CSS, JS, fonts
└── hugo.toml            # Site configuration
```

## Creating a New Post

```bash
hugo new posts/my-new-post/index.md
```

This creates a page bundle with front matter from the archetype. Add `index.en.md` manually for the English version.

## License

The source code (theme, templates, configuration) is licensed under the [MIT License](LICENSE).

Blog content (posts, images, and other media in `content/` and `static/assets/`) is **copyright &copy; 2019-present Rully Pratama. All rights reserved.**
