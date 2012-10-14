class ProjectMarker

  constructor: (@map, project) ->
    marker_opts =
      lat: project.latitude
      lng: project.longitude
      infoWindow:
        content: @infoWindowContent(project)

    @map.addMarker(marker_opts)

  infoWindowContent: (project) ->
    ich.project_info_window(project)


window.WS.ProjectMarker = ProjectMarker