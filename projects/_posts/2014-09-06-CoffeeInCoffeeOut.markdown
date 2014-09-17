---
layout: default
created: "2014-09-06T07:59"
title: "Coffee In Coffee out"
tagline: "Putting my {coffee mug} online"
date: "2014-09-17T07:59"
thickbox: true
---

I have this neat coffee mug that uses themal paint to show how full it is.  Its more cute than
pratical.  Looking at my cup one day while thinking about internets and things, this project
formed into my mind along with a question.  Can I tell how full a coffee cup is by just
temperatues?  Because if I know that, I can figure out how much and how fast I drink coffee.
Which mean I can figure out how much caffiene I've had, and then how long it sticks around in
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
[Moteino][] on a breadbaord with way too much wire between that and the sensors.  I will be at
somepoint here trimming that down and having everything connected to the cup.

First, I did some tests with the sensors on the outside of the cup.  If this got good enough
data, that would be cleaner than putting them in the cup. (<small>it didn't.</small>)<br />
<a href="/projects/images/CICO-SensorsOutside.jpg" class="thickbox"><img src="/projects/images/CICO-SensorsOutside-thumb.jpg" alt="Sensors mounted on the outside of the cup" /></a>

So, some hot glue for strength and heat shrinked.<br />
<a href="/projects/images/CICO-HeatShrunkLTA.jpg" class="thickbox"><img src="/projects/images/CICO-HeatShrunkLTA-thumb.jpg" alt="Sensors wrapped in heat shrink tubing" /></a>

And into the coffee:<br />
<a href="/projects/images/CICO-LTAinCoffee.jpg" class="thickbox"><img src="/projects/images/CICO-LTAinCoffee-thumb.jpg" alt="Sensors inside cup with coffee" /></a>


## Building the Gateway



[Moteino]: http://lowpowerlab.com/moteino/
[TMP36]: https://www.adafruit.com/products/165 
[1020]: https://www.adafruit.com/products/1020
[BeagleBone]: http://beagleboard.org
[Exosite]: http://exosite.com

