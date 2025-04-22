---
layout: post
title:  "About GitHub Pages and Jekyll"
date:   2025-04-22 12:55:00 -0700
categories: github-pages jekyll
---

# About GitHub Pages and Jekyll

GitHub Pages is a static site hosting service that takes HTML, CSS, and JavaScript files directly from a repository on GitHub. It can publish the website through a custom domain or a github.io domain. With GitHub Pages, you can host your personal, organization, or project documentation directly from your GitHub repository.

## Jekyll Integration

Jekyll is a static site generator with built-in support for GitHub Pages. It takes Markdown and HTML files and creates a complete static website based on your choice of layouts. Jekyll supports Markdown and Liquid, a templating language that loads dynamic content on your site.

### Key Features

#### 1. Front Matter

Front matter is a powerful feature that allows you to set variables and metadata for pages and posts. It's written at the top of files in YAML format:

```yaml
---
layout: post
title: "My Blog Post"
date: 2025-04-22
---
```

#### 2. Themes

You can add a Jekyll theme to customize the look and feel of your site. GitHub Pages supports several default themes, or you can use a custom theme:

```yaml
theme: minima
```

#### 3. Plugins

GitHub Pages supports several Jekyll plugins by default:

- jekyll-coffeescript
- jekyll-default-layout
- jekyll-gist
- jekyll-github-metadata
- jekyll-optional-front-matter
- jekyll-paginate
- jekyll-readme-index
- jekyll-titles-from-headings
- jekyll-relative-links

#### 4. Syntax Highlighting

Code snippets are highlighted on GitHub Pages sites the same way they're highlighted on GitHub:

{% highlight javascript %}
function sayHello(name) {
  console.log(`Hello, ${name}!`);
}
sayHello('World');
// Outputs: Hello, World!
{% endhighlight %}

## Building Locally

You can test your GitHub Pages site locally using Jekyll. To do so, you'll need:

1. Ruby
2. Bundler
3. Jekyll

Then you can run:

```bash
bundle exec jekyll serve
```

This will start a local server at `http://localhost:4000` where you can preview your site.

## Conclusion

GitHub Pages combined with Jekyll provides a powerful and flexible way to create and host websites. Whether you're creating documentation, a personal blog, or a project site, this combination offers the tools you need for a successful web presence.

[Learn more about GitHub Pages and Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll) 