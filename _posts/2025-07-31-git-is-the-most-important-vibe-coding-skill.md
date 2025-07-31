---
layout: post
title: Git Is The Most Important Vibe Coding Skill
date: 2025-07-31 07:13:20 -0700
categories: blog
created: 2025-07-31T07:13
updated: 2025-07-31T07:33
---
There is lots of discussion about "Vibe Coding" lately. As I have said in other posts, I treat the LLM as the fastest, worst junior dev I have ever worked with.

Among junior devs who have Dunning Krueger-ed their way into a vibe coding senior dev roll, there are lots of complaints about what the LLM does to their codebase. The regressions, odd wanderings and sometimes self-defeating arson of a code base that can come from letting an LLM run free.

To me this is funny, because these junior devs don't understand that the LLM's often do to codebases what Junior devs do to codebase. Of course, I only know this because I was once a Junior dev. 

I honestly have never seen an LLM do something to a code base that I haven't also done or seen done to a codebase. A lot of times massive mistakes are created by doing "what makes sense". 

The answer to this problem I think is to deepen and utilize Git techniques. 

My favorite resources for this knowledge comes from WizardZines, specifically the evocatively titled [Oh Shit Git](https://wizardzines.com/zines/oh-shit-git/), but the zine [How Git Works](https://store.wizardzines.com/products/how-git-works) is also useful. 

Having good Git habits -- branching at the appropriate time, having good git branch names, git commits with the right amount of information, etc -- mitigates a vast amount of problems when it comes to using the Large Language Model to help write code. 

I am of a certain generation so I still use the command line for most of my git and LLM interface, but I have used [Sublime Merge](https://www.sublimemerge.com/) and didn't hate it -- I just never got fast enough for it. 

One thing I would caution against, however: you might be tempted to let the LLM Agent use git for you. I did for a moment until one day the LLM fixed a bug, created a git commit and then pushed the fix to master, deploying the fix on the server.

This was amazing to see but terrifying to comprehend. From that point forward I have specifically forbade all LLM's I work with from using any git commands. 