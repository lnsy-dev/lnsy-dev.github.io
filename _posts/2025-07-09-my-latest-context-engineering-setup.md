---
layout: post
title: My Latest Context Engineering Setup
date: 2025-07-09 07:25:54 -0700
categories: blog
created: 2025-07-09T07:25
updated: 2025-07-09T07:54
tags:
  - cognitive-load
  - getting-rid-of-google
  - google
  - large-language-models
  - code
  - generative-ai
---
## The Problem

I recently finished two projects using mostly Cursor. It was a blast. I’m used to managing teams overseas, and while the code that comes back from the LLMs isn’t of the same quality, it is delivered at a spectacular velocity, allowing us to ship and iterate quickly.

As I often say: an LLM coding with you is like having the fastest, worst junior dev you’ve ever worked with. It’s a spectacular tool but requires a certain amount and kind of management.

There were, of course, a few problems. Cursor’s models are a moving target, as is their pricing. Throughout the projects the application began behaving differently based on the same inputs. Prompts and techniques that worked at the beginning of the project stopped working midway through. Models that were the basis of what I was doing were put behind paywalls with no real notice.

Integration with tools like Figma was interesting but still half-baked. Cursor “helps” too much—it’s great for making big edits, but the moment you want to change the copy of a header, then the hallucinations and popovers start getting in your way.

## My Solution

I have gone back to using [Sublime Text](https://www.sublimetext.com/) with some custom plugins I’ve written that make editing markdown easier. From the markdown, I’ve been using [Google’s Gemini CLI](https://github.com/google-gemini/gemini-cli) (yes, I’ve been trying to get away from Google, but hear me out).

There are a few other options that are still in motion, but I think I’m going to be sticking to the CLI/Sublime combination going forward.

Rather than “prompting,” I have been writing carefully worded markdown files describing the functionality and targets for the LLM. I have gone back to focusing on single files for the LLM—in the end, as a programmer, you have to contemplate cognitive load, and you simply can’t understand what the LLM has done and the consequences of it if you are trying to read 3-4 or a dozen files.

The closer I get to translation, the better the LLM works. That is to say, I am not asking it to reason at all; I am using the LLM as a compiler between natural language and code. I think this presents immense possibilities.

## Small Projects

Another technique utilizing LLMs I’ve been using lately is generating small, prototype-ready demos using the LLM. These entirely vibe-coded projects are the definition of “move fast and break things,” but they are isolated from the larger main project. Once I have things squarely crooked in the prototype, I ask the LLM to generate a memo of lessons learned and structures. Then I can integrate this with the larger application.
## The Future

I am waiting for the hardware to settle before my next major purchase, but I am looking for a computer that can run a large reasoning model locally. I plan to put a Retrieval-Augmented Generation (RAG) framework in front of my prompts that includes a selection of carefully curated code snippets.

The LLM will be far “dumber” than what Claude or Google will offer; its context windows will be far smaller.

But I’d rather have a dumb LLM that only changes when I tell it to and have it tied to my personal machine.

## Conclusion


LLMs have vastly accelerated my software development process, but I think a lot of people are getting distracted by where the velocity is.

It reminds me of when both ES6 features and React shipped at the same time. A lot of people conflated the innovations in EcmaScript with the features provided by React in their minds. Yes, LLMs are increasing the velocity of software development, but not in the place people think.

Mitigating LLMs' weaknesses while using their strengths to augment your own code is the path that is going to lead to an advancement in software. Everything else is hype.
