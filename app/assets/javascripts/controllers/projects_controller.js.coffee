jQuery ($) ->
  return unless $('body.projects.index').length > 0

  map_opts =
    div: '#project_map'
    lat: WeSpruce.current_user.lat
    lng: WeSpruce.current_user.lng

  WeSpruce.project_map = new WeSpruce.AreaMap( map_opts )