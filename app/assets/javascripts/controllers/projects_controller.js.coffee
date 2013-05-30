# INDEX
jQuery ($) ->
  return unless $('body.projects.index').length > 0

  if WS.local_projects && WS.local_projects.length > 0
    lat = WS.local_projects[0].latitude
    lng = WS.local_projects[0].longitude
  else
     lat = WS.current_user.lat
     lng = WS.current_user.lng

  map_opts =
    div: '#project_map'
    lat: lat
    lng: lng

  WS.project_map = new WS.AreaMap( map_opts, WS.local_projects )

success = (position) ->
  lat = position.coords.latitude
  lng = position.coords.longitude

  map_defaults =
    div: '#map_preview'
    mapTypeControl: false
    panControl: false
    disableDoubleClickZoom: true

  # Set hidden form fields
  $('#project_latitude').val(lat)
  $('#project_longitude').val(lng)

  WS.previewMap = new GMaps( _.extend(map_defaults, {lat: lat, lng: lng}) )
  WS.previewMap.addMarker({lat: lat, lng: lng})
  $('#map_preview').css('height', '300px')

  #$('#map_preview iframe').remove()
  # $('#map_preview').append('<iframe width="100%" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=' + position.coords.latitude + ',' + position.coords.longitude + '&amp;ie=UTF8&amp;output=embed"></iframe>')

error = () ->
  alert("Error getting location")

$ () ->
  $('.geolocate').click () ->
    navigator.geolocation.getCurrentPosition(success, error)


# SHOW
jQuery ($) ->
  return unless $('body.projects.show').length > 0

  $streets = $('#streetview')

  latlng = new google.maps.LatLng($streets.data('lat'), $streets.data('lng'))
  # WS.project_street_view = new google.maps.StreetViewPanorama(document.getElementById('streetview'), {position: latlng})


# NEW
jQuery ($) ->
  return unless $('body.projects.new').length > 0 || $('body.projects.edit').length > 0

  WS.updateMap = (data) ->

    # Set hidden form fields
    $('#project_latitude').val(data.latitude)
    $('#project_longitude').val(data.longitude)

    if WS.previewMap
      WS.previewMap.setCenter(data.latitude, data.longitude)
      WS.previewMap.addMarker({lat: data.latitude, lng: data.longitude})

    else
      map_defaults  =
        div: '#map_preview'
        mapTypeControl: false
        panControl: false
        disableDoubleClickZoom: true

      WS.previewMap = new GMaps( _.extend(map_defaults, {lat: data.latitude, lng: data.longitude}) )
      WS.previewMap.addMarker({lat: data.latitude, lng: data.longitude})
      $('#map_preview').css('height', '300px')

  WS.searchAddress = (evt) ->
    evt.preventDefault()
    $.get('/projects/search', {query: $('#address').val()}, WS.updateMap )
    return false

  $('#submit_address').click( WS.searchAddress )


  if $('body.projects.edit').length > 0
    WS.updateMap({latitude: WS.project.latitude, longitude: WS.project.longitude})
