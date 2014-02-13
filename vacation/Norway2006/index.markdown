---
layout: default
created: "2006-08-16 09:51:50 -0500"
title: "Norway 2006"
date: "2006-08-16 09:51:50 -0500"
---


<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAU9FcxzJwXx21bGXQgLxylBSdGmmDg5_3RZUZXpJ50kVdIn0kwBTSMSBVX-eYQ1fTvGTk_-P2aQWOXQ" type="text/javascript"></script>
<script src="kmlontomap.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
window.onload = function(e) {
  if (GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById("map"));
    map.addControl(new GLargeMapControl());
    map.addControl(new GMapTypeControl());
    map.addControl(new GOverviewMapControl());
    map.setCenter(new GLatLng(65.3324,18.4383), 4);
    kmlontomap(map, "Norway2006.kml");
  }
}
window.onunload = function(e) {
  GUnload();
}
//]]>
</script>
<!-- kmlontomap() can be replaced with:
var gx = new GGeoXml("Norway2006.kml");
map.addOverlay(gx);

Maybe later, but keep in mind.
-->

Friends and I had been talking about something like this for a couple of years now.  See, Erling is from Norway and there is a ferry system that travels up and down the coast.  Then after he moved back to his homeland last year-ish, we gained another reason to do this trip.  Start with a bit of research and planning (<small>which I let Ken and Erling do all the work of. lazy, lazy me.</small>), and we got ourselves set up to ride the [M/S Kong Harald](http://www.ferry-site.dk/ferry.php?id=9039119&lang=en) of the [Hurtigruten](http://www.hurtigruten.com/) down from [Kirkenes](http://en.wikipedia.org/wiki/Kirkenes) to [Bergen](http://en.wikipedia.org/wiki/Bergen,_Norway).  Add to this a few extra days to see Bergen and [Oslo](http://en.wikipedia.org/wiki/Oslo) to see the cities.  And that builds up this vacation.

A fun trip overall.  Definitely one of the more laid back ones; plenty of time on the boat to just sit and watch scenery drift by.  Being able to meet with some of Erling's family the last couple of days and seeing Norway from a non-tourist perspective really added a wonderful depth to the trip.

Also being a techie, I brought along my GPS receiver so I could link all my photos to about where I took them.  A little scripted glue and I get a [kml file](Norway2006.kml) for the photos.  Which can be loaded with Google Earth, or the map below. (<small>if javascript is on and you're in a supported browser.</small>)

<div id="map" style="height: 500px">
	<!-- can't decide if I should add a static image with image map as a fall back, or just leave it empty? -->
	<!-- can i do a client side image map in here without it interfering with google's map? -->
</div>


## Brief Summery
- Day 1  &mdash; [3 Aug 2006](day1.html) &mdash; Made it to Oslo, Norway
- Day 2  &mdash; [4 Aug 2006](day2.html) &mdash; Iron mine and Russian border
- Day 3  &mdash; [5 Aug 2006](day3.html) &mdash; Boarding the M/S Kong Harald
- Day 4  &mdash; [6 Aug 2006](day4.html) &mdash; North Cape
- Day 5  &mdash; [7 Aug 2006](day5.html) &mdash; Lofoten Islands
- Day 6  &mdash; [8 Aug 2006](day6.html) &mdash; Torghatten
- Day 7  &mdash; [9 Aug 2006](day7.html) &mdash; Trondheim
- Day 8  &mdash; [10 Aug 2006](day8.html) &mdash; Off the ferry at Bergin
- Day 9  &mdash; [11 Aug 2006](day9.html) &mdash; Fl&oslash;ibanen and Bryggen
- Day 10 &mdash; [12 Aug 2006](day10.html) &mdash; Vigeland and Holmenkollen
- Day 11 &mdash; [13 Aug 2006](day11.html) &mdash; Viking and Kon-Tiki boats

