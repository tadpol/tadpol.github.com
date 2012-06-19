
function createMarker(point, name, description) {
    var marker = new GMarker(point);
    GEvent.addListener(marker, 'click', function() {
        marker.openInfoWindowHtml("<h1>" + name + "</h1>" + description);
    });
    return marker;
}

function kmlontomap(map, kml) {
    GDownloadUrl(kml, function(data, responseCode) {
        var doc = GXml.parse(data);
        var placemarks = doc.getElementsByTagName('Placemark');
        for(i=0;i<placemarks.length;i++){
            var point = placemarks[i].getElementsByTagName("Point")[0];
            var coords = point.getElementsByTagName("coordinates")[0].childNodes[0].nodeValue;
            coords = coords.split(",");
            var name = placemarks[i].getElementsByTagName("name")[0].childNodes[0].nodeValue;
            var description = placemarks[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;
            
            var pnt = new GPoint(parseFloat(coords[0]), parseFloat(coords[1]))
            map.addOverlay(createMarker(pnt, name, description));
        }
    });
}

