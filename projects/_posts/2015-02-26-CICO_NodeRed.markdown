---
layout: default
created: "2015-02-26T07:57"
title: "Coffee In Coffee out with Node-RED"
tagline: "Putting my {coffee mug} online"
date: "2015-02-26T07:57"
thickbox: true
---


As part of my [Coffee In Coffee Out][CICO] project, I needed a gateway to take the data from the
[Moteino][]s and push it up to the internet.  I started out with some kludged scripts that
mostly worked just fine.  But they had some oddness since they were very blocking and single
threaded.  Plus I wasn't thrilled to try and build up something new where I knew there had to
be a bunch of prior work.  Given the choice, I'd rather build upon the bugs others have solved,
than to re-solve them myself.

So I went hunting for a IoT gateway project.  There were a few choices, but I don't remember the
others.  Since once I came across [Node-RED][] I knew I found what I wanted.  It wasn't without
some missing parts, but they were small and allowed me to give a little back.

The first piece was to create a node that would write (<small>or read</small>) from
[Exosite][]. It was fun to dive into the way Node-RED works and do a little more with
[Node.js][].  The resulting [node-red-node-exosite][] can be installed with npm, and the source
is on [github][nrne-github].

[Node-RED][] is pretty easy to install on your desktop and start playing with it.  Getting it
install on a [BeagleBone][] is also quite easy.  Getting it setup to run from an init.d script
was a few extra steps.  It would be an incredible improvement if [Node-RED][] had a [.deb][debs]
to install with.  This [gist](https://gist.github.com/Belphemur/cf91100f81f2b37b3e94) helped
getting that process started, but I had some changed that were specific to my setup.

With that in place, I built up the flow to get data from the UART over to Exosite.<br/>
<a href="/projects/images/CICO-FirstFlow.png" class="thickbox" rel="CICO"><img src="/projects/images/CICO-FirstFlow-thumb.png" alt="The flow from Node-RED for taking data from UART to Exosite" /></a><br/>
(<small>Fern is the other [Moteino][] I have that is collecting Temperature, Humidity and
Lux.</small>)

It took two small script functions to twist the data around.  The first to convert the lines
from the UART into objects, and the second to build the alias to value map that Exosite uses.

Field splits:<br/>
```javascript
var values = msg.payload.split(' ');
msg.device = values[0].replace(/\[|\]/g,'');
msg.payload = values.slice(1);
return msg;
```

Array To Map:<br/>
```javascript
var pl = {};
pl.rssi = msg.payload[0];
pl.temp0 = msg.payload[2];
pl.temp1 = msg.payload[3];
pl.temp2 = msg.payload[4];
pl.temp3 = msg.payload[5];
pl.temp4 = msg.payload[6];
pl.temp5 = msg.payload[7];
pl.temp6 = msg.payload[8];
pl.battery = msg.payload[9];
msg.payload = pl;
return msg;
```


[CICO]: /projects/2014/09-17/CoffeeInCoffeeOut.html
[debs]: https://www.debian.org/distrib/packages
[Moteino]: http://lowpowerlab.com/moteino/
[Exosite]: http://exosite.com
[BeagleBone]: http://beagleboard.org
[Node.js]: http://nodejs.org
[Node-RED]: http://nodered.org
[node-red-node-exosite]: https://www.npmjs.com/package/node-red-node-exosite
[nrne-github]: https://github.com/tadpol/node-red-node-exosite

