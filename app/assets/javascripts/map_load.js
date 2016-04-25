// var lat = $('#latitude_field').val();
// var long = $('#longitude_field').val();
//
// function initMap(){
//   lat = $('#latitude_field').val();
//   long = $('#longitude_field').val();
//   function placeMap(lat, long){
//     var mapProp = {
//       center: new google.maps.LatLng(lat, long),
//       zoom: 15,
//       mapTypeId: google.maps.MapTypeId.ROADMAP
//     };
//     map = new google.maps.Map(document.getElementById("map-canvas"), mapProp);
//   }
// }
//
// window.onload = initMap();

// function createMarker(place) {
//   placeLoc = place.geometry.location;
//   marker = new google.maps.Marker({
//     map: map,
//     animation: google.maps.Animation.DROP,
//     position: placeLoc
//   });
// }

// var map;
// var lat = $('#latitude_field').val();
// var long = $('#longitude_field').val();
//
// function initMap() {
//   map = new google.maps.Map(document.getElementById('map'), {
//     center: new google.maps.LatLng(lat, long),
//     zoom: 15,
//     mapTypeId: google.maps.MapTypeId.ROADMAP
//   });
// }

// var map;
function initMap() {
  lat = $('#latitude_field').val();
  long = $('#longitude_field').val();
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: new google.maps.LatLng(lat, long),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
}
