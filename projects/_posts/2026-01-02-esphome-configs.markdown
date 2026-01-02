---
layout: default
created: 2026-01-02T14:28:20-0600
title: "Custom home automation devices with ESPHome"
tagline: "Using {ESPHome} to create custom {home automation devices}"
date: 2026-01-02T14:28:20-0600
---

I've been using [ESPHome][] for a while now to create custom home automation devices that integrate seamlessly with [Home Assistant][]. ESPHome allows you to write simple (or sometimes not) YAML configuration files to define the behavior of your devices, making it easy to add things to your smart home setup.

I've setup a github repository to hold my various [ESPHome configurations](https://github.com/tadpol/esphome).  A few examples of what I've done with ESPHome follow.  I've used a variety of ESP8266 and ESP32 based boards for these projects, the only challenge I've had is with boards that have limited flash memory.  So I stick to boards with at least 4MB of flash.

## Water Heater Monitor

This is the simplest of the projects I've done with ESPHome.  It is a basic way to [monitor my water heater](https://github.com/tadpol/esphome/blob/develop/water-heater.yaml) usage.  There is a 1-wire temperature sensor on each of the two pipes going into/out of the water heater, as well as one ambient temperature sensor to monitor room temperature.

By watching the temperature changes, you can see when hot water is being used, and when the heater is running.

## Cat Fountain Monitor

Moderately complex, this [project monitors water level in a cat fountain](https://github.com/tadpol/esphome/blob/develop/cat-fountain.yaml) using two capacitive level sensors, lighting a LED based on the water level.  The logic to control the LED color is done on device, so it works even if Home Assistant is down.

Two "D2CS-H Non-contact type" capacitive water level sensors are installed on the outside of the fountain at different heights to indicate levels for notification.  One as a warning level, and one as a critical low level.  In Home Assistant, you can set up automations to notify you at different levels.

The fountain is a Catit Flower Fountain, which has a plastic body that the sensors can detect through. The sensors are just hot-glued to the outside of the fountain.  This doesn't affect the sensor operation, keeps them in place, and is still easy to remove if needed.

## IR LED strip controller

This is the most complex of my ESPHome projects.  In my office, I have an [LED strip](https://github.com/tadpol/esphome/blob/develop/led-strip-ctrl.yaml) around the ceiling that can change colors.  It is controlled by an IR remote.  I used an ESP8266 with an IR receiver to capture the remote codes, and then an IR LED to send those codes to the LED strip controller.  The challenge was that I wanted to use the Light integration in Home Assistant for control, not just all of the remote buttons.

These types of IR controlled are all over, and so there are a multitude of existing projects that I gathered inspiration from.  Starting with [this one](https://community.home-assistant.io/t/ir-remote-to-template-light-with-all-controls/464122) which gave me the jumping point for the ideas I needed.  Most of the projects focused on doing the mapping within Home Assistant, but I wanted to do as much as possible on the device side.

I ended up using many of the more advanced components of ESPHome, including templated outputs, mapping table, and script lambdas.  The end result is a light that can be controlled from Home Assistant with RGB color selection, and the ESPHome device translates those commands into the appropriate IR codes to send to the LED strip controller.

[ESPHome]: https://esphome.io/
[Home Assistant]: https://home-assistant.io/
