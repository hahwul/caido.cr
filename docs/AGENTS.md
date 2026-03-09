# AGENTS.md - AI Agent Instructions for caido.cr Documentation Site

This document provides instructions for AI agents working on the caido.cr documentation site.

## Project Overview

This is the documentation site for [caido.cr](https://github.com/hahwul/caido.cr), a Crystal client library for Caido's GraphQL API. The site is built with [Hwaro](https://github.com/hahwul/hwaro), a fast and lightweight static site generator written in Crystal.

## Hwaro Usage

### Installation

**Homebrew:**
```bash
brew tap hahwul/hwaro
brew install hwaro
```

**From Source (Crystal):**
```bash
git clone https://github.com/hahwul/hwaro.git
cd hwaro
shards install
shards build --release --no-debug --production
# Binary: ./bin/hwaro
```

### Essential Commands

| Command | Description |
|---------|-------------|
| `hwaro init [DIR]` | Initialize a new site |
| `hwaro build` | Build the site to `public/` directory |
| `hwaro serve` | Start development server with live reload |
| `hwaro version` | Show version information |
| `hwaro deploy` | Deploy the site (requires configuration) |

### Build & Serve Options

- **Drafts:** `hwaro build --drafts` / `hwaro serve --drafts` (Include content with `draft = true`)
- **Port:** `hwaro serve -p 8080` (Default: 3000)
- **Open:** `hwaro serve --open` (Open browser automatically)
- **Base URL:** `hwaro build --base-url "https://example.com"`

## Directory Structure

```
.
├── config.toml          # Site configuration
├── AGENTS.md            # AI agent instructions
├── content/             # Markdown content files
│   ├── index.md         # Homepage
│   ├── user-guide/      # User Guide section
│   │   ├── _index.md
│   │   ├── getting-started.md
│   │   ├── basic-usage.md
│   │   ├── queries.md
│   │   ├── mutations.md
│   │   └── pagination-filtering.md
│   └── api-reference/   # API Reference section
│       ├── _index.md
│       ├── client.md
│       ├── queries.md
│       ├── mutations.md
│       └── utils.md
├── templates/           # Jinja2 templates
│   ├── header.html      # HTML head partial
│   ├── footer.html      # Footer partial
│   ├── page.html        # Default page template
│   ├── section.html     # Section listing template
│   ├── 404.html         # Not found page
│   ├── taxonomy.html
│   ├── taxonomy_term.html
│   └── shortcodes/
│       └── alert.html
└── static/              # Static assets
    ├── css/
    │   └── style.css    # Main stylesheet (Apple-style design)
    └── js/
        └── search.js    # Client-side search (Fuse.js)
```

## Content Management

### Creating New Pages

Create a `.md` file in the appropriate `content/` subdirectory.

**Front Matter (TOML):**
```toml
+++
title = "Page Title"
description = "Page description for SEO"
weight = 1
+++

Your markdown content here.
```

### Content Sections

- **User Guide** (`content/user-guide/`): Practical guides for using caido.cr
- **API Reference** (`content/api-reference/`): Complete API documentation

### Front Matter Fields

| Field | Type | Description |
|-------|------|-------------|
| title | string | Page title (required) |
| description | string | Page description for SEO |
| weight | integer | Sort order (lower = first) |
| draft | boolean | If true, excluded from production build |
| tags | array | List of tags |

## Template Development

### Templates use Jinja2 syntax (Crinja)

- `header.html` and `footer.html` are included as partials
- `page.html` renders individual pages with sidebar navigation
- `section.html` extends page layout with section listing
- Sidebar navigation is hardcoded in templates (update when adding pages)

### Key Variables

- `{{ page.title }}` - Page title
- `{{ page.description }}` - Page description
- `{{ content }}` - Rendered content
- `{{ base_url }}` - Site base URL
- `{{ site.title }}` - Site title

## Styling

- Apple-style design with frosted glass header, fixed sidebar
- CSS custom properties in `:root` for consistent theming
- Responsive: sidebar hidden on screens <= 768px
- Search modal triggered by Cmd+K

## Notes for AI Agents

1. **Always preserve front matter** when editing content files.
2. **Update sidebar navigation** in both `page.html` and `section.html` when adding/removing pages.
3. **Use `hwaro serve`** to preview changes locally.
4. **Keep the Apple-style design** consistent with fm.cr documentation.
5. **Use `weight` in front matter** to control page ordering within sections.
6. **Keep URLs relative** using `{{ base_url }}` prefix.
