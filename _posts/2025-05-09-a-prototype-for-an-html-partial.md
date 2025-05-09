---
layout: post
title: A Prototype For An Html Partial
date: 2025-05-09 05:06:15 -0700
categories: blog
created: 2025-05-09T05:06
updated: 2025-05-09T05:13
tags:
  - html
  - webdev
  - javascript
  - es6
  - custom-html-elements
---
[Get the Code Here](https://github.com/lnsy-dev/html-partial)

I like the idea of an HTML partial. Ideally, servers would have the ability to construct an HTML page from a simple HTML input. This would be wildly useful and would replace quite a bit of the technical complexity that goes into things like WordPress and Next.js and other frameworks. It would let us serve plain html with very little css and javascript. It would let us break up our web pages into semantic blocks so we can focus deeply on generating well structure XML for both human and robot consumption. 

It would look something like this when implemented: 

```html
<html>
<head>
	<html-partial src="metadata.html"></html-partial>
</head>
	<html-partial src="content-05-09-2025.html"></html-partial>
</html>
```

This theoretical html partial lets us re-use metadata.html and content.html to construct a single html file. 

I wrote a prototype of what this could look like utilizing Custom HTML elements. It looks like this: 

```js

class HTMLPartial extends HTMLElement {

 connectedCallback(){
   this.shadowdom = this.getAttribute('shadowdom')
   this.src = this.getAttribute('src')
   if(this.src === null){
      this.innerHTML = '<error>HTML PARTIAL REQUIRES SOURCE</error>'
   }
   fetch(this.src)
    .then(res => res.text())
    .then(res => {
      if(this.shadowdom){
        this.shadow = this.attachShadow({mode: 'open'})
        this.shadow.innerHTML = res
      } else {
        this.innerHTML = res
      }
    })
  }
}

customElements.define('html-partial', HTMLPartial)

```

