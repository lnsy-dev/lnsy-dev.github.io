---
layout: post
title: The Simplest Js Router
date: 2025-05-08 08:54:15 -0700
categories: blog
created: 2025-05-08T08:54
updated: 2025-05-08T09:00
tags:
  - router
  - webdev
  - javascript
  - ecmascript
  - es6
  - code
  - vibe-coding
  - prototypes
---
Here is the simplest router I have figured out in Javascript: 


```js

function getURLValues(URL = window.location.href ){
  const search_params = new URLSearchParams(URL)
  let options = {}
  for (const [key, unparsed_value] of search_params) {
    if(key !== window.location.origin + window.location.pathname + '?' ){
      try {
        const value = JSON.parse(decodeURI(unparsed_value))
        options[key] = value
      } catch {
        options[key] = decodeURI(unparsed_value)
      }
    }
  }
  return options
}

function setURLValues(obj){
  let url = window.location.origin + window.location.pathname + '?'
  Object.keys(obj).forEach(key => {
    url += `&${key}=${obj[key]}`
  })
  history.pushState(obj, '', url)
}

```

