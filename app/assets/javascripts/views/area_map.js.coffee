# Dependencies: gmaps

class AreaMap

  gmap = null

  defaults:
    mapTypeControl: false
    panControl: false

  constructor: (opts = {}, projects = [] ) ->
    @gmap = new GMaps(_.extend(@defaults, opts))
    @addMarkers( projects )

  addMarkers: (projects) ->
    for project in projects
      marker = new WS.ProjectMarker(@gmap, project)


window.WS.AreaMap = AreaMap