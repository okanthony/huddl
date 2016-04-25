var map;
function initMap() {
  lat = $('#latitude_field').val();
  long = $('#longitude_field').val();
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: new google.maps.LatLng(lat, long),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
}

// function createMarker(place) {
//   placeLoc = place.geometry.location;
//   marker = new google.maps.Marker({
//     map: map,
//     animation: google.maps.Animation.DROP,
//     position: placeLoc
//   });
// }
//
// lat = $('#latitude_field').val();
// long = $('#longitude_field').val();
// map = new google.maps.Map(document.getElementById('map-canvas'), {
//   center: new google.maps.LatLng(lat, long),
//   zoom: 15,
//   mapTypeId: google.maps.MapTypeId.ROADMAP
// });
