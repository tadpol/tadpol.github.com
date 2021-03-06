---
layout: default
created: "2006-07-09 16:23:22 -0500"
title: "Twisty paths of pieces of code"
date: "2006-07-09 16:23:22 -0500"
---


Amazing how things that aren't quite important get lost when you randomly follow them down the paths they take.  I don't even remember what package got me started on all of this.  Basically, there was some <a href="http://darwinports.opendarwin.org/">port</a> I wanted to install.



This thing with installing Ports on the mac is you're never quite sure what else gets installed.  Yeah, you can do `port deps foo` and see what foo needs.  But what if those ports aren't installed, and what about their needs?  A seemingly small port with a single dependency could quickly force your machine to spend the next day and a half downloading and compiling if you're not careful.



So I wrote a little bit of <a href="http://www.ruby-lang.org/">ruby</a> to figure out *all* of the dependencies a port will require.  I started this in <a href="http://iolanguage.com/">Io</a> actually, but got stuck when it appeared that Io doesn't callout to shell programs.  The script is simple, and doesn't support variants to a port, mostly because `port deps` doesn't support variants. (<small>Rather, I cannot figure out how to get it to work, if it does.</small>)



Given the smallness, I'm just dumping it right here:



	#!/usr/bin/env ruby

	# 9 July 2006 by Michael Conrad Tadpol Tilstra

	# find all deps for given port[s]

	# currently ignores varients.

	# results prefixed with + are not currently installed on your system.



	if ARGV.empty?

		puts "portalldep <ports>"

		exit

	end

	found = Hash.new

	search = ARGV.dup



	search.each {|i| found[i] = '+'}



	while not search.empty?

		pt = search.shift

		res = %x{port deps #{pt}}.scan(/\t(.*)\n/).flatten

		res.delete_if {|i| found.has_key? i}

		res.each {|i| found[i] = '+'}

		search += res

	end



	installed = %x{port installed}.scan(/^\s+(\S+)\s+/).flatten

	found.each_key {|k| found[k] = ' ' if installed.include? k}

	found.keys.sort.each { |k| puts " #{found[k]}#{k}"}



Funfun.  So given the smallness, I didn't feel it deserved an entry in the <a href="/projects/index.html">projects</a> tree.  However I also didn't want to just dump in into the <a href="/bog/index.html">bog</a> either.  This is when I'm like "oh yeah, I've got categories don't I?".  So poke around <a href="http://ranchero.com/marsedit/">MarsEdit</a> for a while, trying to figure out how to create a new category.  Huh, doesn't look like there is a way to do that.



Not a problem, this is what the <a href="http://www.apple.com/macosx/features/applescript/">AppleScript</a> menu is for.  Spent a rather confused morning trying to remember (<small>and learn</small>) AppleScript.  That language has never quite made sense to me.  Though it probably didn't help any that I started out with a rather complex window that I was going to load from a nib.  I had wanted something more of a category manager.  Once I dropped all that and went with a simple dialog to create new categories everything got easier.  (<small>Still had to figure out AppleScript though.</small>)



It doesn't work yet though.  Seems the only way I can find to get MarsEdit to reload categories for a Blosxom type of weblog is to restart it.  Bummer.  Well, I posted to the <a href="http://www.newsgator.com/forum/messages.aspx?ForumID=11">forum</a>, now I wait.  Here's the current script anyways.



	(*

	New Blosxom Category

	

	Lets you create new categories for blosxom compatible weblogs.  Just pops a 

	dialog asking for the category name, and if it doesn't already exist, does a 

	shell callout to make the directory.

	

	Uses 'mkdir -p'  so you can create nested categories just by putting '/'s into 

	the new category name.

	

	9 July 2006 by Michael Conrad Tadpol Tilstra

	Copyright 2006 Michael Conrad Tadpol Tilstra

	*)

	

	tell application "MarsEdit"

		try

			set wb to selected weblog

			set bpath to Blosxom folder path of wb

			set cats to category names of wb

		on error errMsg

			display alert "Greeee!" message "Doesn't seem like you have a Blosxom type of weblog selected." as critical

			return

		end try

		

		set res to display dialog "New Category:" default answer ""

		if button returned of res is not "OK" then

			return

		end if

		set newCat to text returned of res

		if newCat does not end with "/" then

			set newCat to newCat & "/"

		end if

		if newCat is in cats then

			display alert "Category " & newCat & " all ready exists" as warning

			return

		end if

		

		set newPath to bpath & newCat

		do shell script "mkdir -p " & newPath

		

		-- get MarsEdit to reload the categories for this weblog...

		-- umm, i think you need to restart MarsEdit to have it reload blosxom categories.

		-- ick.

	end tell

		



Course, putting all this code inline makes me wish for some sort of pretty printing stuff to be added to the rendering code for my site.  Which I may or may not add.  In either case, I pretty much expect this entry to get edited a couple of times after I post it.  At the very least, I'd like to see the applescript get finished and moved over to projects.



Now this is about where I discover that I don't actually have category support.  What I have is the nifty discovery of FileList doing depth searches in <a href="http://rake.rubyforge.org/">Rake</a>.  So it finds, and renders entries in categories just fine.  Linking them however is broken.  So now I'm also stuck with the task of implementing that.  Or not, since this entry is the first time I've really thought of using categories.



Maybe I'll just work on pretty print of inlined code blocks.  Or maybe, since the sun went to bed, I'll do the same thing.






