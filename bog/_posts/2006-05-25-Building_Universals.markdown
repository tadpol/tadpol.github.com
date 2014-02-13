---
layout: default
created: "2006-05-25 16:21:09 -0500"
title: "Building Universals"
date: "2006-05-25 16:21:09 -0500"
---


Need to build a universal version of a library for work.  I was kind of worried that it would be an overly involved process of rebuilding the library's Makefiles.  But my fears seem to be proven false.  The hardest part was digging through the docs and tech notes on Apple's site. But I finally found the <a href="http://developer.apple.com/documentation/Porting/Conceptual/PortingUnix/index.html">decoder ring</a>.



That can be summarized down to, if you're lucky: `setenv CFLAGS "-isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc"`.  And lo, I was lucky.  (<small>We only need the static version of the library, so that helped a bunch.</small>)



Of course its not all roses and cherries.  While working in the main tree, now compiling universal as well, I fiddled some lines and went to recompile.  Discovering quite quickly that `ar` really doesn't know a thing about fat library files.  So pushed back the universal switch.  Later I'll have to go in and make it do universal when building test and release versions, and stay off for debug versions.



All in all though, it is pretty smooth path to getting universal binaries even without XCode.

