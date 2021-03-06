---
layout: default
created: "2007-10-23 09:48:07 -0500"
title: "Lake Powell 2007"
date: "2007-10-23 09:48:07 -0500"
---


<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAU9FcxzJwXx21bGXQgLxylBQtuUYA7RnZglDVjcBHLDX2eYjMThR_sf22doHgBgqFefg3ktiiLxtdnw" type="text/javascript"></script>
<script src="kmlontomap.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
window.onload = function(e) {
  if (GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById("map"));
    map.addControl(new GLargeMapControl());
    map.addControl(new GMapTypeControl());
    map.addControl(new GOverviewMapControl());
    map.setCenter(new GLatLng(37.37889,-110.80261), 10);
    kmlontomap(map, "lakepowell2007.kml");
  }
}
window.onunload = function(e) {
  GUnload();
}
//]]>
</script>
 

This year for vacation, I did the [Hidden Canyons of Lake Powell](http://www.rei.com/adventures/trips/namer/az_powell.jsp) [Rei Adventures](http://www.rei.com/adventures) trip.  The Lake Powell area is quite the beautiful place.  The color contrasts between the blues of the lake, the reds of the sand and stone, up to the blues of the sky.  The dry emptiness throughout that reminds you that this is a desert, even when standing with your feet in the lake water.

The thing about hiking in canyons, is that you go up and down; a lot.  Partly to show how much, and partly just because I have the data and can show it off. (<small>GPS is still so neat.</small>) Here's a quick graph of the elevation changes.  (<small>The rather flat bits are where we kayaked.</small>)
<img src="images/elevationChanges.png" style="padding-bottom: 1em;" />

<!-- more words? -->

Here is a map of the trails that we hiked and paddled.  The colors match those in the elevation graph.
<map name="GraffleExport">
	<area shape="poly" coords="184,146,183,137,158,112,145,98,131,99,124,114,90,126,86,143,61,161,64,165,94,144,116,126,136,119,155,119,174,135,179,148,184,146" href="day4.html" />
	<area shape="poly" coords="191,144,169,163,139,197,134,193,165,157,191,144" href="day2.html" />
	<area shape="poly" coords="38,108,54,110,71,94,82,89,102,89,124,79,123,64,93,77,65,76,38,108" href="day5.html" />
	<area shape="poly" coords="189,143,240,116,246,96,234,85,189,126,185,136,189,143" href="day3.html" />
	<area shape="rect" coords="548,36,567,52" href="day6.html" />
	<area shape="rect" coords="475,211,595,222" href="day6.html" />
	<area shape="rect" coords="466,199,595,210" href="day5.html" />
	<area shape="rect" coords="458,187,595,198" href="day5.html" />
	<area shape="rect" coords="471,175,595,186" href="day5.html" />
	<area shape="rect" coords="464,163,595,174" href="day4.html" />
	<area shape="rect" coords="480,152,595,163" href="day4.html" />
	<area shape="rect" coords="485,140,595,151" href="day3.html" />
	<area shape="rect" coords="397,129,595,140" href="day3.html" />
	<area shape="rect" coords="480,117,595,128" href="day2.html" />
	<area shape="rect" coords="214,219,384,235" href="http://www.GPSVisualizer.com" />
</map>
<img src="images/lakepowellmap.png" usemap="#GraffleExport" style="padding-bottom: 1em;" />

<!--
    Am having all sorts of second guessing on the google maps stuff.  Is techie neat, but *major* pain in ass to get working.  And really don't want to think of what it might require to maintain…
-->

Then a nifty google map showing where the photos on the following pages where took.

<div id="map" style="height: 400px">
</div>



## Brief Summery

- Day 1 -- [15 Oct 2007](day1.html) -- Met at Airport, five hour drive to Bullfrog
- Day 2 -- [16 Oct 2007](day2.html) -- Houseboat ride to Escalantay branch and base camp
- Day 3 -- [17 Oct 2007](day3.html) -- Hike over to overlook of Colorado branch
- Day 4 -- [18 Oct 2007](day4.html) -- Kayak and Hike up Davis Gulch
- Day 5 -- [19 Oct 2007](day5.html) -- Kayak and Hike up 50 Mile Creek
- Day 6 -- [20 Oct 2007](day6.html) -- Pack up camp, check out some ruins, back to marina
- Day 7 -- [21 Oct 2007](day7.html) -- Drive back to Salt Lake City, check out Goblins on the way.

