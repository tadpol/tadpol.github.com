---
layout: default
created: "2006-12-22 09:57:28 -0600"
title: "BBEdit and Make"
date: "2006-12-22 09:57:28 -0600"
---


[BBEdit][] has compilation integration stuff for some common IDEs.  I can sorta remember way back when I used them how nice that was.  Unfortunately, all of my current work is done with [CMake][] to Make.  Which is all command line tools.  The Shell Worksheets are nice, but they're not really what I want.  And beyond that, there really isn't much out-of-the-box linking to the command line build tools.

Mostly, I'm just want the errors from the compile to be clickable.  So they popup the correct file with the cursor in the right place.  Fortunately, this is doable with a little scripted glue.  When I've made some changes to a file, I can just hit ⌘K, and up pops either a dialog saying it compiled fine, or the results browser with the errors.  Its also smart enough to toss out the old error list, though you still have to save first yourself. (<small>I could have it auto-save, but my brain doesn't like that for some reason.</small>)

Take this script, drop it into `~/Library/Application Support/BBEdit/Unix Support/Unix Scripts/`, then in [BBEdit][], open the Unix Scripts Palette and give it a key combo.  I use ⌘K.

A lot of the methodology for this script came from a how-to on getting [GPC and BBEdit working][gpc-bbedit] together.


[Download](archives/makeone.v1.zip) it.


[BBEdit]: http://www.barebones.com/products/bbedit/
[CMake]: http://www.cmake.org
[gpc-bbedit]: http://pascal-central.com/gpc2.html

