# Lindsey Mysse's GitHub Pages Site

This is the repository for my personal website, hosted on GitHub Pages using Jekyll.

## About This Site

This site is built with Jekyll, a static site generator with built-in support for GitHub Pages. It takes Markdown and HTML files and creates a complete static website based on layouts and themes.

## Local Development

### Prerequisites

- Ruby version 3.2.2 or higher (recommended to use Homebrew on macOS)
- RubyGems
- GCC and Make

### Setup

1. **Ruby Environment Setup (macOS with Homebrew)**:
   
   For macOS users, it's recommended to use Homebrew Ruby instead of the system Ruby:
   ```
   brew install ruby
   ```
   
   Then set up your environment (you can use our setup script):
   ```
   ./setup-ruby-env.sh
   ```
   
   This will configure the correct Ruby paths in your shell configuration.

2. **Quick Start**:
   
   Use our start script to set up everything automatically:
   ```
   ./start.sh
   ```
   
   This script:
   - Sets up the Ruby environment
   - Installs required gems
   - Cleans previous build artifacts
   - Starts Jekyll with live reload

3. **Manual Setup** (if not using the start script):
   ```
   # Set Ruby paths
   export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
   export GEM_HOME="$HOME/.gem"
   export PATH="$GEM_HOME/bin:$PATH"
   
   # Install dependencies
   bundle install
   
   # Run the site locally
   bundle exec jekyll serve
   ```

4. Open your browser to `http://localhost:4000`

### Directory Structure

- `_posts/`: Blog posts
- `_layouts/`: HTML templates
- `_includes/`: Reusable components
- `_tags/`: Tag pages for hashtags
- `_config.yml`: Site configuration
- `index.md`: Home page
- `about.md`: About page

## Adding Content

### Blog Posts

To add a new blog post, create a file in the `_posts` directory with the following format:

```
YEAR-MONTH-DAY-title.md
```

For example: `2025-04-22-my-new-post.md`

Include front matter at the top of the file:

```yaml
---
layout: post
title: "My New Post"
date: 2025-04-22 12:00:00 -0700
categories: blog
---

Your content here, written in Markdown...

#tag1 #tag2 #tag3
```

### Using Hashtags

This site supports hashtags in your Markdown content:

1. **Adding Hashtags**: Simply add hashtags anywhere in your post content like `#jekyll` or `#tutorial`.
2. **Tag Pages**: Each unique hashtag will have its own page at `/tags/hashtag`.
3. **Tag Index**: Browse all tags at `/tags/`.
4. **Generating Tag Pages**: After adding new hashtags, run:
   ```
   ./create-tag-pages.sh
   ```
   to generate tag pages for any new hashtags.

### Pages

To add a new page, create a file in the root directory with a `.md` or `.html` extension, and include front matter:

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