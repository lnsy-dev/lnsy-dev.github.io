---
layout: html
title: Custom Html Elements
date: 2025-04-22 18:23:36 -0700
categories: blog
created: 2025-04-22T18:23
updated: 2025-04-22T18:51
---


  <div id="border">
    <div class="grid-container">
      <article class="two-up">
        <h2 style="font-size: 24pt;">Custom HTML Elements</h2>
        <p><small>Last Updated 30 Nov, 2023</small></p>
        <lazy-img src="./assets/00182-1353117845.png"></lazy-img>
        <br>
        <h3>Introduction</h3>
        <p>My favorite feature of ES6+ is Custom HTML Elements. Custom Elements allow us to extend HTML for React-Like components without the need for preprocessors or compilers. There are fewer things "out of the box" for these components, but that means they can be lighter and more readable than react.</p>
        <p>You can use these components as you would any other html elements. Each component needs a dash in its name. So </p>
        <pre><code>&lt;componentelement&gt;&lt;/componentelement&gt;</code></pre>
        <p> is not valid, but</p>
        <pre><code>&lt;component-element&gt;&lt;/component-element&gt;</code></pre>
        <p>is.</p>
      </article>
      <article>
        <h3>A basic element</h3>
        <p>Here is a basic element that gets an attribute called <b>title</b> on load and sets its internal HTML to it.</p>
      </article>
      <article>
        <pre><code>
class CustomHTMLElement1 extends HTMLElement {
  constructor(){
    super();
    this.title = this.getAttribute('title');
    if(this.title === null){
      this.title = 'CUSTOM ELEMENT';
    } 
    this.innerHTML = `${this.title}`;
  }
}

customElements.define('custom-element-1', CustomHTMLElement1);
</code></pre>
        <script type="module">
          class CustomHTMLElement1 extends HTMLElement {
  constructor(){
    super()
    this.title = this.getAttribute('title');
    if(this.title === null){
      this.title = 'CUSTOM ELEMENT';
    } 

    this.innerHTML = `${this.title}`
  }
}

customElements.define('custom-element-1', CustomHTMLElement1)

</script>
      </article>
      <article class="two-up">
        <p>
          If we instantiate this component with:</p>
        <pre><code>&lt;custom-element-1 title=&quot;This sets the title Attribute&quot;&gt;&lt;/custom-element-1&gt;</code></pre>
        <p>We get this result</p>
        <p class="block">
          <custom-element-1 title="This sets the title Attribute"></custom-element-1>
        </p>
      </article>
      <article>
        <h3>Change an attribute with Javascript</h3>
        <p>
          We can change attributes by setting <b>observedAttributes</b> and <b>attributeChangedCallback</b> functions. If we wanted to change the "title" attribute with javascript the new component would look like:
        </p>
      </article>
      <article>
        <pre><code>    
class CustomHTMLElement2 extends HTMLElement {
  constructor(){
    super()
    this.title = this.getAttribute('title');
    if(this.title === null){
      this.title = 'CUSTOM ELEMENT';
    } 
    this.innerHTML = `${this.title}`
  }

  static get observedAttributes() {
    return ['title'];
  }

  attributeChangedCallback(name, oldVal, newVal) {
    if(name === 'title'){
      this.innerHTML = `${newVal}`
    }
  }
}

customElements.define('custom-element-2', CustomHTMLElement2)
</code></pre>
      </article>
      <article class="two-up">
        <p>If we instantiate a component like this: </p>
        <pre><code>&lt;custom-element-2 id=&quot;custom_element_2&quot; title=&quot;old title&quot;&gt;&lt;/custom-element-2&gt;</code></pre>
        <p>We can then change the title like so:</p>
        <pre><code>setInterval(() => {
  custom_element_2.setAttribute('title', Math.random());
},1000);</code></pre>
        <p>And the result looks like this:</p>
        <p class="block">
          <script type="module">
            class CustomHTMLElement2 extends HTMLElement {
  constructor(){
    super()
    this.title = this.getAttribute('title');
    if(this.title === null){
      this.title = 'CUSTOM ELEMENT';
    } 

    this.innerHTML = `${this.title}`
  }

  static get observedAttributes() {
    return ['title'];
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if(name === 'title' && newValue !== null){
      this.innerHTML = `${newValue}`
    }
  }
}

customElements.define('custom-element-2', CustomHTMLElement2);

</script>
          <custom-element-2 id="custom_element_2" title="old title"></custom-element-2>
        </p>
        <script>
          setInterval(() => {
  custom_element_2.setAttribute('title', Math.random());
},1000);
</script>
      </article>
      <article>
        <h3>An Asynchronous Loading Pattern</h3>
        <p>I use this pattern a lot for components that might take a while to load. This component introduces the <b>connectedCallback</b> function. The <b>connectedCallback</b> function runs when the component is attached to the DOM. It runs after the constructor. In this example I use <b>connectedCallback</b> to run an asynchronous function called <b>init</b>. </p>
      </article>
      <article>
        <pre><code>class AsyncComponent extends HTMLElement {
  constructor(){
    super()
    this.title = this.getAttribute('title');
    if(this.title === null){
      this.title = 'CUSTOM ELEMENT';
    } 
    this.innerHTML = `Loading...`
  }

  connectedCallback(){
    this.init();
  }

  slowResponse(){
    return new Promise((res, rej) => {
      setTimeout(() => {
            res();
      }, 3000)
    })
  }

  async init(){
    await this.slowResponse()
    this.innerHTML = '<b>Component Loaded!</b>'
  }

  static get observedAttributes() {
    return ['title'];
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if(name === 'title' && newValue !== null){
      this.innerHTML = `${newValue}`
    }
  }
}

customElements.define('async-component', AsyncComponent);</code></pre>
      </article>
      <article class="two-up">
        <script type="module">
          class AsyncComponent extends HTMLElement {
  constructor(){
    super()
    this.title = this.getAttribute('title');
    if(this.title === null){
      this.title = 'CUSTOM ELEMENT';
    } 
    this.innerHTML = `Loading...`
  }

  connectedCallback(){
    this.init();
  }

  slowResponse(){
    return new Promise((res, rej) => {
      setTimeout(() => {
            res();
      }, 3000)
    })
  }

  async init(){
    await this.slowResponse()
    this.innerHTML = '<b>Component Loaded!</b>'
  }

  static get observedAttributes() {
    return ['title'];
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if(name === 'title' && newValue !== null){
      this.innerHTML = `${newValue}`
    }
  }
}

customElements.define('async-component', AsyncComponent);
</script>
        <p>This function waits for the <b>slowResponse</b> function to run, and then changes its content to loaded.</p>
        <div class="block">
          <p id="new_component_container"></p>
          <p>Click this button to create a new <b>async-component</b>:</p>
          <p><button id="new_component">Create a new component</button></p>
        </div>
        <style>
          async-component {
    display: block;
    margin-bottom: 1em;
  }
</style>
        <script type="module">
          new_component.addEventListener('click', function() {
    const new_async_component = document.createElement("div");
    new_async_component.innerHTML = '<async-component></async-component>'
    console.log(new_component_container, new_async_component);
    new_component_container.appendChild(new_async_component);
  })
</script>
      </article>
      <article>
        <h3>Styling Custom Components</h3>
        <p>Components can be styled like any other HTML Element. Initially in the box model they act like <strong>span</strong> tags, so style your <strong>display</strong> tag in CSS accordingly. </p>
      </article>
      <article>
        <pre><code>class StyledComponent extends HTMLElement {
  constructor(){
    super()
    this.innerHTML = 'This is a Styled Component'
  }
}
customElements.define('styled-component', StyledComponent);</code></pre>
        <pre><code class="lang-CSS">styled-component {
  background-color: red;
  color: white; 
  border: 1px dashed black;
  padding: 1em;
  display: block;
}</code></pre>
      </article>
      <article class="two-up">
        <script type="module">
          class StyledComponent extends HTMLElement {
  constructor(){
    super()
    this.innerHTML = 'This is a Styled Component'
  }
}

customElements.define('styled-component', StyledComponent);
  </script>
        <style>
        styled-component {
          background-color: red;
          color: white;
          border: 1px dashed black;
          padding: 1em;
          display: block;
          margin-bottom: 1em;
        }
        </style>
        <p class="block">
          <styled-component></styled-component>
        </p>
      </article>
      <article class="two-up">
        <h3>More Information</h3>
        <ul>
          <li><a href="https://javascript.info/custom-elements">Javascript Info has a more in depth article</a></li>
          <li><a href="https://developer.mozilla.org/en-US/docs/Web/API/Web_Components/Using_custom_elements">MDN on Custom Elements</a></li>
          <li><a href="https://css-tricks.com/creating-a-custom-element-from-scratch/">CSS Tricks Article</a></li>
        </ul>
      </article>
    </div>
  </div>
