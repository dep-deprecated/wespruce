class ProjectMarker

  constructor: (@map, project) ->
    marker_opts =
      lat: project.latitude
      lng: project.longitude
      infoWindow:
        content: @infoWindowContent(project)

    @map.addMarker(marker_opts)

  infoWindowContent: (project) ->
    p = project
    "<div id='project_#{p.id}'><h6>#{p.name}</h6><p>#{p.description}</p><div class='rating rating-#{p.rating}'></div>"

  stars: (rating) ->
    '*' for star in rating


window.WS.ProjectMarker = ProjectMarker