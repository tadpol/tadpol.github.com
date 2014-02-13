---
layout: default
created: "2006-06-29 16:22:38 -0500"
title: "Daily Reboot"
date: "2006-06-29 16:22:38 -0500"
---


I'm not fully sure I will ever be able to truly capture my opinions on the quality of the broadband I have.  I only have two choices, DSL or cable.  Since cable doesn't allow personal servers, I have DSL.  Now just this on the surface, it works as one would expect.  The clincher takes some time.



After a while, the DSL modem locks up.  How long this takes appears to be related to traffic load.  More traffic, quicker time to lockup.  If I max the up and down bandwidth for about 10 minutes, the modem will lock up sometime in the next couple of hours.  That in-precision of timing is what makes this so frustrating.  Current usage gives me roughly three days of running before it locks up.



The lock up is fixed by rebooting my modem.  How much of this is resetting my hardware, or breaking the link and letting their hardware restart, I don't know.  This solution is also the one that is stated on the web site and what you're given if you phone support.  So this is how I'm stuck fixing it.  So, automation.



Finding an inexpensive single port NPS is difficult, besides, I've got X10 stuff lying around unused.  So, grab the base module and the firecracker and TADA! I can reboot the DSL modem automagically.  This brings up the second major suck of my modem.



I run servers.  I like to be able to get to these, by name, from other machines that are within my home network.  This is often referred to as nat loopback.  For what ever reason I cannot get (<small>or figure out</small>) my modem to save this setting to nvram.  I finally gave up and just wrote a small expect script.  Bit kludgly, but it gets the job done.



So now I've got something to restart and reconfigure my DSL modem.  Now if I was super-cool, I'd tie this into some kind of daemon that would detect when the DSL locked up.  Probably by pinging some outside host.  But I'm lazy, so I just used cron.  I figure if I just 'restart' the time to lock up faster than it actually locks up, it won't get a chance to lock up on me.  (<small>I hope.</small>)  I'll see how this goes, if this doesn't work out, I'll try building up the ping detect daemon thing.




