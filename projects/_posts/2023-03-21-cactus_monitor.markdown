---
layout: default
created: "2023-03-21T23:43:23.265Z"
title: "Cactus Monitoring"
tagline: "Collecting the {tech} used to monitor a cactus"
date: "2023-03-21T23:43:23.265Z"
---

Collecting the tech used to monitor a cactus.  (First post in six years. 😳 so out of practice…)

This system is largely built from things that I had laying around. It works well enough.  I have a mishmash of sensors using the 915MHz that collect through the common gateway here and into [Home Assistant][], but going to focus just on the plant here.

Most new things that I add are using [ESPHome][], but these aren't broke.

## The bits

Three parts here, from the top down.

### Collection and Dashboards

On the top of it all, I'm now running [Home Assistant][] to handle all the work of collecting and displaying of data.
In the past, I used [NodeRED][] and a bunch of things there.  But as I tried to pull in various other home automation things, I got tired
of the amount of rebuilding to make and keep the flows working.
I have [Home Assistant][] running in [Docker][] on my [Synology][].

### Gateway Bridge

For the Gateway and Sensors, I'm using the 2.3.2 version of [MySensors][].  The gateway software is from the [esp8266 gateway](https://www.mysensors.org/build/esp8266_gateway) with the following setup for the radio.

```c
#define MY_RADIO_RFM69
#define MY_RFM69_FREQUENCY RFM69_915MHZ
#define MY_IS_RFM69HW
#define MY_RFM69_ENABLE_ENCRYPTION
#define MY_RFM69_IRQ_PIN    15
#define MY_RFM69_IRQ_NUM    digitalPinToInterrupt(MY_RFM69_IRQ_PIN)
#define MY_RFM69_CS_PIN     2
#define MY_RFM69_RST_PIN    16
```

The gateway hardware is:

- [Adafruit Feather HUZZAH with ESP8266](https://www.adafruit.com/product/2821)
- [Adafruit Radio FeatherWing](https://www.adafruit.com/product/3229)

Then I printed a [custom case](https://github.com/tadpol/scads/blob/master/Cases/feather-stacked.scad). But any box will work.

### Sensor Nodes

The plant sensor hardware is built on [Moteino][]s because I have a bunch of these from a prior project.

- [Moteino](https://lowpowerlab.com/shop/product/99) With the RFM69HCW
- [WeatherShield](https://lowpowerlab.com/shop/product/123)
- [GA1A12S202 Log-scale Analog Light Sensor](https://www.adafruit.com/product/1384) This is discontinued, but any analog or digital light level sensor could be used.
- [SparkFun Soil Moisture Sensor](https://www.sparkfun.com/products/13322)

The firmware for this sensor is a combination of the following examples:

- [Moisture](https://www.mysensors.org/build/moisture)
- [Humidity](https://www.mysensors.org/build/humidity_si7021) The WeatherShield I have on the plant uses the Si7021
- [Light](https://www.mysensors.org/build/light-lm393) While I'm using a different sensor, analog is analog.

[Home Assistant]: https://home-assistant.io/
[ESPHome]: https://esphome.io/
[NodeRED]: https://nodered.org/
[Docker]: https://docker.com/
[Synology]: https://synology.com/
[MySensors]: https://www.mysensors.org/
[Moteino]: https://lowpowerlab.com/moteino/
