---
layout: default
created: "2025-03-15T14:22:48-0500"
title: "Home Assistant Widget for iOS"
tagline: "Making an {iOS Home Assistant} widget"
date: 2025-03-15T14:22:48-0500"
---

I wanted a quick glance of some of the data I have collected in [Home Assistant][] on my iPhone.  Widgets are the way to go with this.  I had some time ago played with a custom widget for weather data using [Scriptable][].  So I dug into adapting that to get its data from my [Home Assistant][] instead of from [WunderGround](https://wunderground.com).

The first step was to create a [Long-lived access token](https://developers.home-assistant.io/docs/auth_api#long-lived-access-token) so we could use the [RESTful API](https://developers.home-assistant.io/docs/api/rest).  All we are doing is grabbing the state of some sensors and then displaying them, which makes the API usage quite straightforward.  I had already setup Tailscale on my [Synology][] and iPhone, so this widget will work no matter where I am.

Next to build up the [Scriptable][] script.  This is just javascript, with some custom things for working on iOS.  I kept it simple and just used a [ListWidget](https://docs.scriptable.app/listwidget/) with emoji for color.  The most complex parts of the script are where I convert wind direction to arrows, and converting measured temperature into feels-like temperature.

<a href="/projects/images/scriptable_weather_widget.png" data-lightbox="CICO"><img width=237 height=237 src="/projects/images/scriptable_weather_widget.png" alt="Screen capture of the weather widget showing current conditions" /></a><br/>

The script isn't the most re-usably written, but its small.

```js
// Variables used by Scriptable.
// These must be at the very top of the file. Do not edit.
// icon-color: blue; icon-glyph: snowflake;

// Change these (and occurrences of them in code below) to the sensors you'd like
const sensors = [
  "temperature",
  "humidity",
  "wind_average",
  "wind_direction",
  "uv",
  "rain",
  "strike_count",
  "strike_distance",
];
const url = "https://<host & port of your HASS>/api/states";
const apiKey = "<long-lived access token from HASS>";


async function get_one_sensor(sensor) {
  try {
    const req = new Request(url + '/sensor.' + sensor);
    req.headers = {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${apiKey}`,
    };
    const result = await req.loadJSON();
    return result;
  } catch (error) {
    console.log(`E: ${sensor} :: ${error}`);
  }
}

async function get_sensors() {
  const results = await Promise.allSettled(
    sensors.map(s => get_one_sensor(s))
  );
  const reply = {};
  for(let i = 0; i < sensors.length; i++) {
    reply[ sensors[i] ] = results[i].status === "fulfilled" ?
      results[i].value : {};
  }
  return reply;
}

const result = await get_sensors();
//console.log(result)

const feelLike = feels_like(
  Number(result['temperature'].state),
  Number(result['wind_average'].state),
  Number(result['humidity'].state),
);

const w = new ListWidget();
w.addText([ '🌡: ', Number(feelLike).toFixed(1), '°F', ].join(''));
w.addText(`💦: ${sensor_str(result['humidity'])}%`);
w.addText([
  '🎐:',
  sensor_str(result['wind_average'], 0),
  windDir(result['wind_direction'].state)
].join(' '));
w.addText(`☀️: ${sensor_str(result['uv'])}`);
w.addText(`☔️: ${sensor_str(result['rain'])}`);
w.addText([
  '🌩️: ',
  sensor_str(result['strike_count']),
  ' (',
  sensor_str(result['strike_distance']),
  ')',
].join(''));

//w.addText(`⚗️: ${}`);

function sensor_str(sensor, places) {
  let v = Number(sensor.state);
  if (!Number.isInteger(v)) {
    v = v.toFixed(places!==undefined?places:2);
  }

  return v.toString();
}

if (config.runsInWidget) {
  Script.setWidget(w);
  Script.complete();
} else {
  QuickLook.present(w);
}

// The feels like functions came from equations I found on NOAA’s site.
function wind_chill(temp, wind) {
  const p_wind = Math.pow(wind, 0.16);
  return 35.74 + (0.6215 * temp) - (35.75 * p_wind) + (0.4275 * temp * p_wind);
}
function heat_index(temp, hum) {
  // Do simple first (and avg with temp)
  const shi = (temp + (0.5 * (temp + 61 + ((temp - 68) * 1.2) + (hum * 0.094)))) / 2;
  if (shi < 80) {
    return shi;
  }
  // If over 80, then need full equation with adjustments

  const c = [
    -42.379,
    2.04901523,
    10.14333127,
    -0.22475541,
    -6.83783e-3,
    -5.481717e-2,
    1.22874e-3,
    8.5282e-4,
    -1.99e-6,
  ];
  const hum1 = hum / 100;
  const temp2 = Math.pow(temp, 2);
  const hum2 = Math.pow(hum1, 2);

  const fhi = c[0] +
    (c[1] * temp) +
    (c[2] * hum1) +
    (c[3] * temp * hum1) +
    (c[4] * temp2) +
    (c[5] * hum2) +
    (c[6] * temp2 * hum1) +
    (c[7] * temp * hum2) +
    (c[8] * temp2 * hum2);

  let adj = 0;
  if( hum < 13 && temp > 80 && temp < 112) {
    adj = ((0.13 - hum1)/4) * Math.sqrt((17-Math.abs(temp-95))/17);
  } else if( hum > 85 && temp > 80 && temp < 87) {
    adj = ((hum1-0.85)/10) * ((87 - temp)/5);
  }

  return fhi - adj;
}

function feels_like(temp, wind, hum) {
  if (temp <= 61 && wind >= 3) {
    return wind_chill(temp, wind);
  } else if(temp >= 70) {
    return heat_index(temp, hum);
  }
  return temp;
}

function windDir(d) {
  if(d >=0 && d < 22.5) {
    return "⬇️";
  } else if(d >= 22.5 && d < 68) {
    return "↙️";
  } else if(d >= 68 && d < 113) {
    return "⬅️";
  } else if(d >= 113 && d < 158) {
    return "↖️";
  } else if(d >= 158 && d < 203) {
    return "⬆️";
  } else if(d >= 203 && d < 248) {
    return "↗️";
  } else if(d >= 248 && d < 293) {
    return "➡️";
  } else if(d >= 293 && d < 338) {
    return "↘️";
  } else if(d >= 338) {
    return "⬇️";
  }
}
```

[Home Assistant]: https://home-assistant.io/
[Scriptable]: https://scriptable.app
[Synology]: https://synology.com/
