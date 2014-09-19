---
layout: default
created: "2014-09-06T07:59"
title: "Coffee In Coffee out"
tagline: "Putting my {coffee mug} online"
date: "2014-09-17T07:59"
thickbox: true
---

I have this neat coffee mug that uses thermal paint to show how full it is.  Its more cute than
practical.  Looking at my cup one day while thinking about internets and things, this project
formed into my mind along with a question.  Can I tell how full a coffee cup is by just
temperatures?  Because if I know that, I can figure out how much and how fast I drink coffee.
Which means I can figure out how much caffeine I've had, and then how long it sticks around in
my body.

I set off to find out.


## The Plan

Being that this was going to get attached to a coffee mug, it needed to be wireless.  I had two
[Moteino][]s that I bought for another project that got put on hold.  Now the temperature
sensor; I'm not quite sure what the name for this is, but I've been going with Linear
Temperature Array.  Buying six 1-Wire sensors was a bit more than I wanted to spend, and analog
is easy enough, so I just picked up six [TMP36][].  I also grabbed some [food-grade heat
shrink][1020] because I assumed that the temperature sensors needed to be as close to the
coffee as possible.

This [Moteino][] will be broadcasting back to another acting as a gateway.  That one will be
connected to a [BeagleBone][] white, also from that other project.  The bone will be running a
script to take the data from the [Moteino][] and sending it to the <strike>internet</strike>
cloud.  I choose to use [Exosite][] because of employment bias.


## Building the Mug Sensors

First step was doing a bunch of point soldering to make my Linear Temperature Array.<br />
<a href="/projects/images/CICO-LinearTemperatureArray.jpg" class="thickbox"><img src="/projects/images/CICO-LinearTemperatureArray-thumb.jpg" alt="Six TMP36 point soldered in a row" \></a>

Since I wanted to do some tests on what kind and quality of data I got back I kept the
[Moteino][] on a breadboard with way too much wire between that and the sensors.  I will be at
some point here trimming that down and having everything connected to the cup.

First, I did some tests with the sensors on the outside of the cup.  If this got good enough
data, that would be cleaner than putting them in the cup. (<small>it didn't.</small>)<br />
<a href="/projects/images/CICO-SensorsOutside.jpg" class="thickbox"><img src="/projects/images/CICO-SensorsOutside-thumb.jpg" alt="Sensors mounted on the outside of the cup" /></a>

So, some hot glue for strength and heat shrunk.<br />
<a href="/projects/images/CICO-HeatShrunkLTA.jpg" class="thickbox"><img src="/projects/images/CICO-HeatShrunkLTA-thumb.jpg" alt="Sensors wrapped in heat shrink tubing" /></a>

And into the coffee:<br />
<a href="/projects/images/CICO-LTAinCoffee.jpg" class="thickbox"><img src="/projects/images/CICO-LTAinCoffee-thumb.jpg" alt="Sensors inside cup with coffee" /></a>

Then finally cut the wires short and soldered them in. <br />
<a href="/projects/images/CICO-shortenedWires.jpg" class="thickbox"><img src="/projects/images/CICO-shortenedWires-thumb.jpg" alt="Wires cut to
length and soldered to Moteino" /></a><br />
(<small>Still gotta figure out the battery holder…</small>)

## Building the Gateway

This is pretty straightforward; connect the UARTs.

<a href="/projects/images/CICO-firstGateway.jpg" class="thickbox"><img src="/projects/images/CICO-firstGateway-thumb.jpg" alt="Mess of wires for initial gateway" /></a><br />
(<small>ignore the BLE dongle for now.</small>)


## In the Cloud

Having [exoline][] installed makes many tasks with the [Exosite][] platform easier.  For me its
much quicker to write a spec file, and have [exoline][] apply it onto a new [CIK][].


## Data

These are plots of the temperature difference between the top-most sensor and the lower
ones.<br />
<a href="/projects/images/CICO-data-height-outside.jpg" class="thickbox"><img src="/projects/images/CICO-data-height-outside-thumb.jpg" alt="Plot showing temperature differences with sensors outside the cup" /></a>
<a href="/projects/images/CICO-data-height-inside.jpg" class="thickbox"><img src="/projects/images/CICO-data-height-inside-thumb.jpg" alt="Plot showing temperature differences with sensors inside the cup" /></a>

There is a clear dip in temperature difference when the sensors are inside the mug.  When on the
outside, the ceramic interferes too much blurring all the values together.



[Moteino]: http://lowpowerlab.com/moteino/
[TMP36]: https://www.adafruit.com/products/165 
[1020]: https://www.adafruit.com/products/1020
[BeagleBone]: http://beagleboard.org
[Exosite]: http://exosite.com
[exoline]: https://github.com/exosite/exoline 
[CIK]: http://docs.exosite.com/rpc/#remote-procedure-call-api-authentication

