---
layout: default
created: "2006-12-22 09:09:46 -0600"
title: "BBEdit Codeless Language Module for CMake"
date: "2006-12-22 09:09:46 -0600"
---


Another Language Module for [BBEdit][], this time for [CMake][].  This was pretty easy, since [CMake][] is mostly just keywords, and there is a nice command line option to dump out the keywords.  There is no function popup, since [CMake][] doesn't have functions, being a macro language.  Could maybe map the popup to something else, but I've not had any need since the CMakeLists.txt files are so short.

Also, I'm not quite sure how to get it to match complete file names, instead of just a suffix.  So you'll more likely than not need to set the language by hand.

[Download](archives/cmake.plist.zip), unpack, and drop into `~/Library/Application Support/BBEdit/Language Modules`



[CMake]: http://www.cmake.org
[BBEdit]: http://www.barebones.com/products/bbedit/

