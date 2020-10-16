let map
let geocoder


function initMap(){
  geocoder = new google.maps.Geocoder()
  if(document.getElementById('map')){
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 35.6594666, lng: 139.7005536},
      zoom: 13,
    });
  }else{
    let gon = {
      lat: 0,
      lng: 0
    };
    if (document.getElementById('lat') == null || document.getElementById('lng') == null) {
      return;
    }
    if (document.getElementById('lat')) {
      gon.lat = parseFloat(document.getElementById('lat').value);
    }
    if (document.getElementById('lng')) {
      gon.lng = parseFloat(document.getElementById('lng').value);
    }
    map = new google.maps.Map(document.getElementById('show_map'), {
      center: {lat: gon.lat, lng: gon.lng},
      zoom: 13,
    });

    marker = new google.maps.Marker({
      position:  {lat: gon.lat, lng: gon.lng},
      map: map
    });
  }
}
/*
function initMap(){
  getcoder = new google.maps.Geocoder();
  let gon = {
    lat: null, lng: null
  };
  let map = null;
  let div = null;
  let marker = false;
  if (document.getElementById('map')) {
    gon.lat = 35.6594666;
    gon.lng = 139.7005536;
    div = document.getElementById('map');
  } else {
    marker = true;
    gon.lat = getFloatValue('lat');
    gon.lng = getFloatValue('lng');
    div = document.getElementById('show_map');
  }
  if (gon.lat == null || gon.lng == null) {
    return;
  }
  map = new google.maps.Map(div, {center: gon, zoom:13,});

  if (marker != false) {
    marker = new google.maps.Marker({position:gon, map:map});
  }
}

function getFloatValue( var element ){
  if (element == null || document.getElementById(element) == null) {
    return null;
  }
  return parseFloat(document.getElementById(element));
}

*/



function codeAddress(){

  let inputAddress = document.getElementById('address').value;

  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
      let lat = results[0].geometry.location.lat();
      let lng = results[0].geometry.location.lng();
      let mark = {
          lat: lat,
          lng: lng
      };
      map.setCenter(results[0].geometry.location);
      let marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('該当する結果がありませんでした');
    }
  });
}