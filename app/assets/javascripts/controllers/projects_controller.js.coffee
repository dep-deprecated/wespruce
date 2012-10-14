jQuery ($) ->
  return unless $('body.projects.index').length > 0

  map_opts =
    div: '#project_map'
    lat: WS.local_projects[0].latitude
    lng: WS.local_projects[0].longitude

  WS.project_map = new WS.AreaMap( map_opts, WS.local_projects )

success = (position) ->
    $('#project_latitude').val(position.coords.latitude)
    $('#project_longitude').val(position.coords.longitude)

error = () ->
  alert("Error getting location")

$ () ->
  $('#geolocate').click () ->
    navigator.geolocation.getCurrentPosition(success, error)
