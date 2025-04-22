# Lindsey Mysse's GitHub Pages Site

This is the repository for my personal website, hosted on GitHub Pages using Jekyll.

## About This Site

This site is built with Jekyll, a static site generator with built-in support for GitHub Pages. It takes Markdown and HTML files and creates a complete static website based on layouts and themes.

## Local Development

### Prerequisites

- Ruby version 2.5.0 or higher
- RubyGems
- GCC and Make

### Setup

1. Install dependencies:
   ```
   bundle install
   ```

2. Run the site locally:
   ```
   bundle exec jekyll serve
   ```

3. Open your browser to `http://localhost:4000`

### Directory Structure

- `_posts/`: Blog posts
- `_layouts/`: HTML templates
- `_includes/`: Reusable components
- `_config.yml`: Site configuration
- `index.markdown`: Home page
- `about.markdown`: About page

## Adding Content

### Blog Posts

To add a new blog post, create a file in the `_posts` directory with the following format:

```
YEAR-MONTH-DAY-title.markdown
```

For example: `2025-04-22-my-new-post.markdown`

Include front matter at the top of the file:

```yaml
---
layout: post
title: "My New Post"
date: 2025-04-22 12:00:00 -0700
categories: blog
---

Your content here, written in Markdown...
```

### Pages

To add a new page, create a file in the root directory with a `.markdown` or `.html` extension, and include front matter:

```yaml
---
layout: page
title: "My New Page"
permalink: /my-page/
---

Your content here, written in Markdown...
```

## Deployment

The site is automatically deployed when changes are pushed to the `main` branch of this repository.

## Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Markdown Guide](https://www.markdownguide.org/) 