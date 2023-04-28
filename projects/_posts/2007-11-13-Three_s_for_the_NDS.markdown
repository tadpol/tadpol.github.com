---
layout: default
created: "2007-11-13 20:10:23 -0600"
title: "Three's for the NDS"
date: "2007-11-13 20:10:23 -0600"
lightbox: true
---



This is a port of my game [Three's][threes] to the [Nintendo DS][nds].  Since I was mostly just messing around, I wanted to keep development simple.  So I chose to use the [DSLua][] stuff instead of setting up a cross-compiling environment for the [NDS][].  In the grand scheme, I'm not sure how much this really saved me, since [DSLua][] is pretty low level.  I still had to get the hang of many inner detail stuff.  Even so, it worked out well, since it gave me a good excuse to learn [lua][].

The two biggest issues where that I learned [lua][] v5.1 first, then discovered that [DSLua][] is built on v5.0.  So I had to unlearn a bunch of stuff.  The other issue was getting images formatted in the right way.  [DSLua][] v0.7 has initial stuff for direct usage of regular image formats, but to really do anything you still need to get into the raw image formats.  That will probably change in the future, but for now it meant figuring out some deep stuff.

## Screenshot

A truly horrid screen shot done with a cell phone camera.

<a href="/projects/images/ndsThreesScreen.jpg" data-lightbox="A"><img src="/projects/images/ndsThreesThumb.png"/></a>

<!--
## Requirements and Downloads

To run this you will need:
 - [Nintendo DS][nds], regular or lite.
 - Hardware to run [Homebrew][].  I use the [R4DS][].
 - [DSLua][] v0.7
 - NDS Three's v0.1

Once you've got all that, do some setup verification.  Make sure that the [homebrew][] stuff works, and make sure some of the sample [DSLua][] scripts run.  You need to make sure that [DSLua][] runs before trying to run Three's.

## Install and Run

Unzip, then copy the Threes folder to your card.  Run [DSLua][], and browse to the `threes.lua` file and run it.
-->

[threes]: http://tadpol.org/projects/threes.html
[nds]: http://www.nintendo.com/systemsds
[dslua]: http://dslua.com
[lua]: http://lua.org
[R4DS]: http://www.r4ds.com/r4ds.htm
[homebrew]: http://en.wikipedia.org/wiki/Nintendo_DS_homebrew


