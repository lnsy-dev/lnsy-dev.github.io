---
layout: post
title: Html Includes
date: 2025-04-23 17:27:20 -0700
categories: blog
created: 2025-04-23T17:27
updated: 2025-04-23T17:37
---
[Github Repository Here](https://github.com/lnsy-dev/html-partial)

This is an experimental component I put together to emulate how I think HTML includes should work. This component should not be used in production, though I think it is an interesting concept for how we could build websites in a post-Next.js post-React world.

## Usage

Include the html-partial.js file, then you can use it like so:
```html
<html-partial src="html-url"></html-partial>
```
or:
```html
<html-partial src="html-url" shadowdom></html-partial>
```
This partial will then fetch the targeted file and inject it as a string into the divs inner HTML.

This is the code:

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