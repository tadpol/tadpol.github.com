---
layout: default
created: "2006-10-23 14:54:27 -0500"
title: "BBEdit Codeless Language Module for Io"
date: "2006-10-23 14:54:27 -0500"
---



This is something I've been meaning to do for some time now.  There was a great deal of confusion from the [BBEdit][] manual, thankfully I searched up [something][tw] that cleared the air.  [PCRE][] are bordering scary.

There a few little issues.
- The function menu is populated with just the names of slots for methods. (rather, `function_name := method()`)  So if you have a bunch of different objects, all with methods of the same name, the function menu gets a bunch of entries with the exact same name.
- Here is an icky one.  If you write a method on a single line, all following methods disappear from the function menu.  The opening and closing parentheses need to be on different lines.  I don't know if this is my [PCRE][] or [BBEdit][] that is causing this.


[Download](archives/io.plist.zip), unpack, and drop into `~/Library/Application Support/BBEdit/Language Modules`


[BBEdit]: http://www.barebones.com/products/bbedit/
[PCRE]: http://en.wikipedia.org/wiki/PCRE
[tw]: http://www.truerwords.net/articles/bbedit/codeless_language_module.html

