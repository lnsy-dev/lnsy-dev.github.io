---
layout: post
title: Plan Carefully And Query Sparingly
date: 2025-07-15 16:32:34 -0700
categories: blog
created: 2025-07-15T16:32
updated: 2025-07-15T16:33
tags:
  - large-language-models
  - prototypes
  - productivity
  - chatgpt
  - generative-ai
  - google
---
There is a recent study: https://arstechnica.com/ai/2025/07/study-finds-ai-tools-made-open-source-software-developers-19-percent-slower/ that says that programmers who use AI are 19 percent slower than programmers who don't. I have a few quibbles with this study: for instance, the tasks to use AI on were chosen at random, which means the programmers didn't have the opportunity to assess if the LLM would be suited to the job. I haven't found anything about the experience levels of the programmers or their level of experience with the tools they used like Cursor.  

Lately I've been using [Goose](https://block.github.io/goose/) with Google Gemini as the backend. I have query limits (I haven't gone paid with Gemini yet), but I haven't really minded. 

Perhaps I have slowed down a bit -- I spend a lot more time planning and writing about the code I'm working on than I used to. I don't think this is a bad thing, however. 

My general style for coding with LLM's: 

1. Embrace the prototype -- I like to have lots of purely vibe-coded prototypes in separate folders that implement a specific function. When I get something working I have the LLM write a memo about the structure of the code with good working examples. Then I implement the code mostly by hand from the examples the LLM has given me. 
2. Think Translation, not Implementation -- There have been many attempts at computer languages that act like natural human speech. They have all failed in brilliant and hilarious ways. Now we have the single best implementation of this paradigm, and it's amazing. I find I have better success with LLM's when I think about it in terms of using it as a compiler from natural language to a programming language.
3. You're still programming -- Remember in that first programming class where they asked you to describe how to make a peanut butter and jelly sandwich and then the instructor deliberately mis-read your instructions to be wrong? Yeah, thinking this way is really hard, but that's what actual programming is like. The LLM's aren't going to do that for you.
4. Plan carefully and query sparingly -- if you find your LLM is in a loop, the problem is you, not the LLM. Quit asking the robot to do something it's obviously bad at and re-architect the code.
5. Single files and small slices -- I know you can put your entire codebase into an LLM these days. Despite what certain tech CEO's say, it isn't going to actually fix a bug -- it'll spackle over the bug with technical debt.  The LLM doesn't understand architecture and can barely follow an example template. Give the LLM small slices of tasks to implement documented, solved problems. 

I've found these rules of LLM to be useful as I use these new tools. I honestly don't believe LLM's will ever get to the point where they can write a non-trivial app without human assistance, and we humans who love writing software aren't going to lose our careers. 

