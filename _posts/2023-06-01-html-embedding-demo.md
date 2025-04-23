---
layout: post
title: HTML Embedding Demo
date: 2023-06-01
categories: demo
tags: html javascript web-components
created: 2025-04-22T17:54
updated: 2025-04-22T17:54
---

# HTML Embedding Demo

This is a demonstration of embedding HTML with functional script tags in a Jekyll site.

## Custom Element Example

Below is a custom element defined right in this markdown file:

```html
<my-counter></my-counter>

<script>
class MyCounter extends HTMLElement {
  constructor() {
    super();
    this.count = 0;
    this.attachShadow({ mode: 'open' });
    this.render();
  }
  
  render() {
    this.shadowRoot.innerHTML = `
      <style>
        :host {
          display: block;
          font-family: sans-serif;
          text-align: center;
          margin: 2rem 0;
          padding: 1rem;
          border: 1px solid #ccc;
          border-radius: 4px;
        }
        button {
          background: #0078d7;
          color: white;
          border: none;
          padding: 0.5rem 1rem;
          border-radius: 4px;
          cursor: pointer;
          margin: 0 0.5rem;
        }
        .count {
          font-size: 2rem;
          margin: 1rem 0;
        }
      </style>
      <div class="count">${this.count}</div>
      <button id="decrement">-</button>
      <button id="increment">+</button>
    `;
    
    this.shadowRoot.querySelector('#increment').addEventListener('click', () => {
      this.count++;
      this.updateCount();
    });
    
    this.shadowRoot.querySelector('#decrement').addEventListener('click', () => {
      this.count--;
      this.updateCount();
    });
  }
  
  updateCount() {
    this.shadowRoot.querySelector('.count').textContent = this.count;
  }
}

// Register the custom element
customElements.define('my-counter', MyCounter);
</script>
```

## Live Example

Here's the live example of the custom element:

<my-counter></my-counter>

<script>
class MyCounter extends HTMLElement {
  constructor() {
    super();
    this.count = 0;
    this.attachShadow({ mode: 'open' });
    this.render();
  }
  
  render() {
    this.shadowRoot.innerHTML = `
      <style>
        :host {
          display: block;
          font-family: sans-serif;
          text-align: center;
          margin: 2rem 0;
          padding: 1rem;
          border: 1px solid #ccc;
          border-radius: 4px;
        }
        button {
          background: #0078d7;
          color: white;
          border: none;
          padding: 0.5rem 1rem;
          border-radius: 4px;
          cursor: pointer;
          margin: 0 0.5rem;
        }
        .count {
          font-size: 2rem;
          margin: 1rem 0;
        }
      </style>
      <div class="count">${this.count}</div>
      <button id="decrement">-</button>
      <button id="increment">+</button>
    `;
    
    this.shadowRoot.querySelector('#increment').addEventListener('click', () => {
      this.count++;
      this.updateCount();
    });
    
    this.shadowRoot.querySelector('#decrement').addEventListener('click', () => {
      this.count--;
      this.updateCount();
    });
  }
  
  updateCount() {
    this.shadowRoot.querySelector('.count').textContent = this.count;
  }
}

// Register the custom element
customElements.define('my-counter', MyCounter);
</script>

## Interacting with Custom Elements from External Scripts

You can also interact with your custom elements from another script:

<button id="external-button">Reset Counter</button>

<script>
document.getElementById('external-button').addEventListener('click', () => {
  const counter = document.querySelector('my-counter');
  counter.count = 0;
  counter.updateCount();
});
</script>

## How It Works

1. The Jekyll configuration has been updated to allow HTML embedding with proper script execution
2. A helper script in the default layout ensures that all embedded scripts are properly executed
3. Custom elements work seamlessly with the Shadow DOM for encapsulation 