var error, success;

jQuery(function($) {
  var lat, lng, map_opts;
  if (!($('body.projects.index').length > 0)) {
    return;
  }
  if (WS.local_projects && WS.local_projects.length > 0) {
    lat = WS.local_projects[0].latitude;
    lng = WS.local_projects[0].longitude;
  } else {
    lat = WS.current_user.lat;
    lng = WS.current_user.lng;
  }
  map_opts = {
    div: '#project_map',
    lat: lat,
    lng: lng
  };
  return WS.project_map = new WS.AreaMap(map_opts, WS.local_projects);
});

success = function(position) {
  var lat, lng, map_defaults;
  lat = position.coords.latitude;
  lng = position.coords.longitude;
  map_defaults = {
    div: '#map_preview',
    mapTypeControl: false,
    panControl: false,
    disableDoubleClickZoom: true
  };
  $('#project_latitude').val(lat);
  $('#project_longitude').val(lng);
  WS.previewMap = new GMaps(_.extend(map_defaults, {
    lat: lat,
    lng: lng
  }));
  WS.previewMap.addMarker({
    lat: lat,
    lng: lng
  });
  return $('#map_preview').css('height', '300px');
};

error = function() {
  return alert("Error getting location");
};

$(function() {
  return $('.geolocate').click(function() {
    return navigator.geolocation.getCurrentPosition(success, error);
  });
});

jQuery(function($) {
  var $streets, latlng;
  if (!($('body.projects.show').length > 0)) {
    return;
  }
  $streets = $('#streetview');
  return latlng = new google.maps.LatLng($streets.data('lat'), $streets.data('lng'));
});

jQuery(function($) {
  if (!($('body.projects.new').length > 0 || $('body.projects.edit').length > 0)) {
    return;
  }
  WS.updateMap = function(data) {
    var map_defaults;
    $('#project_latitude').val(data.latitude);
    $('#project_longitude').val(data.longitude);
    if (WS.previewMap) {
      WS.previewMap.setCenter(data.latitude, data.longitude);
      return WS.previewMap.addMarker({
        lat: data.latitude,
        lng: data.longitude
      });
    } else {
      map_defaults = {
        div: '#map_preview',
        mapTypeControl: false,
        panControl: false,
        disableDoubleClickZoom: true
      };
      WS.previewMap = new GMaps(_.extend(map_defaults, {
        lat: data.latitude,
        lng: data.longitude
      }));
      WS.previewMap.addMarker({
        lat: data.latitude,
        lng: data.longitude
      });
      return $('#map_preview').css('height', '300px');
    }
  };
  WS.searchAddress = function(evt) {
    evt.preventDefault();
    $.get('/projects/search', {
      query: $('#address').val()
    }, WS.updateMap);
    return false;
  };
  $('#submit_address').click(WS.searchAddress);
  if ($('body.projects.edit').length > 0) {
    return WS.updateMap({
      latitude: WS.project.latitude,
      longitude: WS.project.longitude
    });
  }
});
