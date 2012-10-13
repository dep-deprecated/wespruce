jQuery ($) ->
  return unless $('body.projects.index').length > 0

  map_opts =
    div: '#project_map'
    lat: WS.current_user.lat
    lng: WS.current_user.lng

  WS.project_map = new WS.AreaMap( map_opts, WS.local_projects )