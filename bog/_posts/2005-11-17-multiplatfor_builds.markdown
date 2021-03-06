---
layout: default
created: "2005-11-17 09:43:00 -0600"
title: "Multi-Platform Builds"
date: "2005-11-17 09:43:00 -0600"
---


Thinking a lot about cross compiling lately.  Not architectures, but
operating environments, like Mac OS X, or Windows XP, or KDE, or
GNUStep, or Gnome.  That sort of thing.  It could be a rather sticky
problem, or it might not be.  I've only real experience on one side of
this, so I'm just letting my mind wander.

My current thoughts on this are hovering around the idea of one glorious
build system being a waste.  I vaguely remember the pains of a similar
situation, and how well it never worked.  That was just between linux
and freebsd.  Though most of that mess was trying to get gnumake and
bsdmake to read and work on the same makefiles.  (<small>That it was
kernel driver code probably only made the whole matter worse.</small>) 
It wasn't pretty, I'll just leave it at that.

Part of what is hitting my mind here is the upcoming CPU change for Mac
OS X.  Apple set up XCode to handle the Universal Binary thing already. 
I really don't want to figure out how to write a makefile that will
build Universal Binaries.   The other part is sharing code for a program
that runs on both OS X and XP.  While I know that, with enough elbow
grease, it can be done, I seriously wonder if it is worth the energy. 
It seems that it would be easier to create a new project in whatever
build tool works best for Windows, and build in that.

Basically a given build system has its own target platform in mind, and
thus does a better job for its platform than for a different platform. 
So trying to use a single build system for all of the platforms leads
you to either making sacrifices or massive re-implementation.  Skip some
features, or spend more time building the build system than your
application.  Evil to have to pick between those.

I can think of a couple of stumbling blocks to running with multiple
build systems.  One of which is adding new files.  With multiple build
systems and multiple developers, whose job is it to remember to make
sure each build system gets the new file added?  You will know in any
case quickly when a file is forgotten. (<small>'If'? No way, definitely
a 'when'.</small>)  It becomes a question of how often are new files
added, and how irritated are you when a build fails after a checkout or
update.

Another possible stumbling block is that some build systems have very
concrete ideas on where files should live.  Trying to mix two or three
of these could get rather painful.  I wonder how would you even go about
solving this sort of conflict.  I'm not sure, but then I'm not even sure
this is a problem.

There are other things too I'm sure.  But it feels like it would still
be better to use multiple builds.  Maybe I'm just thinking that because
I don't know what lies head.  I suppose I'll find out.  (<small>Unless I
get out voted on it.  There are other developers, and their opinions on
this matter too.</small>)

