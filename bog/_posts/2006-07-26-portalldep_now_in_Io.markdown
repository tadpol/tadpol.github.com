---
layout: default
created: "2006-07-26 15:10:19 -0500"
title: "portalldep now in Io"
date: "2006-07-26 15:10:19 -0500"
---

Well, I went out and got the latest version (<small>as in pulled down the repo</small>) of <a href="http://iolanguage.com/">Io</a>, because it had the new the <a href="http://www.iolanguage.com/blog/blog.cgi?do=item&amp;id=74">SystemCall</a>.  And then I retried my <a href="Twisty_paths_of_pieces_of_code.html">last attempt</a>.  Hurrah, it works!  I tried making use of coroutines and futures, but they don't seem to be going.  Not sure if it is me or SystemCall.  (<small>it was me.</small>)

May not be the prettiest io, but I'm still trying to figure this out.

Updated, I fear I am having fun. Retweeked to use Set instead of Map. Not really any different.

	#!/usr/bin/env ioDesktop
	#
	# 26 July 2006 by Michael Conrad Tadpol Tilstra
	# find all deps for given port[s]
	# currently ignores varients.
	# results prefixed with + are not currently installed on your system.
	
	if(args size == 0,
	    writeln("portalldeps <ports>")
	    exit(1)
	)
	Set := List clone do(
	    append := getSlot("appendIfAbsent")
	    merge := method(lst, lst foreach(i, append(i)))
	    diff := method(set, set select(v, contains(v) not))
	)
	search := Set clone merge(args)
	search removeFirst
	found := Set clone merge(search)
	
	while(search size > 0,
	    lst := SystemCall clone do(
	        setCommand("port")
	        arguments append("deps", search removeFirst)
	    ) run stdout readLines select(beginsWithSeq("\t")) map(removePrefix("\t"))
	    search merge(found diff(lst))
	    found merge(lst)
	)
	
	installed := SystemCall clone do(
	    setCommand("port")
	    arguments append("installed")
	    ) run stdout readLines select(beginsWithSeq("  ")) map(between("  ", " "))
	found sortBy(block(a,b,a<b)) foreach(k, 
	    if(installed contains(k), 
	        writeln("  " .. k), 
	        writeln("+ " .. k)
	    )
	)

