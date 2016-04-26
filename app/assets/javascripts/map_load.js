function initMap() {
  lat = parseFloat($('#latitude_field').val());
  long = parseFloat($('#longitude_field').val());
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: new google.maps.LatLng(lat, long),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  createMarker(lat, long, map);
}

function createMarker(lat, long, map) {
  placeLoc = {};
  placeLoc.lat = lat;
  placeLoc.lng = long;
  marker = new google.maps.Marker({
    map: map,
    animation: google.maps.Animation.DROP,
    position: placeLoc
  });
}
