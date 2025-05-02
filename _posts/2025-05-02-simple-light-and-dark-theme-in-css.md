---
layout: post
title: Simple Light And Dark Theme In Css
date: 2025-05-02 09:04:00 -0700
categories: blog
created: 2025-05-02T09:04
updated: 2025-05-02T09:05
tags:
  - CSS
  - html
  - webdev
---
### A simple light and dark theme according to user's system preferences

Last Updated 24 Jan, 2023

I just used this and thought I would share it for people who didn't know.

```css
:root {
  --bg-color: white;
  --fg-color: black;
  --secondary-bright-color: #009900;
  --highlight-color: #F57F00;
  --mid-tone-color: grey;
  --editor-border: 1px solid var(--mid-tone-color);
  --logo-color: #224455;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg-color: black;
    --fg-color: white;
    --secondary-bright-color: #00FF00;
    --highlight-color: #F57F00;
    --mid-tone-color: grey;
    --editor-border: 1px solid var(--mid-tone-color);
    --logo-color: orange;
  }
}
```

This generates the css variables to adjust a webpage according to the user's system theme preferences.