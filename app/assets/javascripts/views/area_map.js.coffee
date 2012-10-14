# Dependencies: gmaps

class AreaMap

  gmap = null

  defaults:
    mapTypeControl: false
    panControl: false

  constructor: (opts = {}, projects = [] ) ->
    @gmap = new GMaps(_.extend(@defaults, opts))
    @gatherNodes()
    @registerEvents()
    @addMarkers( projects )

  gatherNodes: ->
    @$new_project_marker = $('#new_project_marker')
    @$new_project_form = $('#new_project_form')

  registerEvents: ->
    @$new_project_marker.on({ dragstart: @startNewProjectDrag })
    # google.maps.event.addListener( @gmap.map, 'dragend', @newProjectDrop )
    # google.maps.event.addListener( @gmap.map, 'drop', @newProjectDrop )
    google.maps.event.addListener( @gmap.map, 'mouseup', @newProjectDrop )

  addMarkers: (projects) ->
    for project in projects
      marker = new WS.ProjectMarker(@gmap, project)

  startNewProjectDrag: (evt) =>
    @draggingNewProject = true

  stopNewProjectDrag: (evt) =>
    @draggingNewProject = false

  newProjectDrop: (evt) =>
    if @draggingNewProject
      lat = evt.latLng.lat()
      lng = evt.latLng.lng()
      @gmap.addMarker(_.extend(@new_project_opts, {lat: lat, lng: lng}))
      @createNewProject(lat, lng)
      @stopNewProjectDrag()

  createNewProject: (lat, lng) ->
    $form = @$new_project_form
    $form.find('[name="project[latitude]"]').val(lat)
    $form.find('[name="project[longitude]"]').val(lng)
    $form.modal({backdrop: 'static', keyboard: true})

    # Set hide on cancel button
    $form.find('.btn-cancel').on('click', (evt) -> $form.modal('hide'))
    $form.on('hidden', (evt) -> $form.find('.btn-cancel').off('click'))

  new_project_opts:
    animation: google.maps.Animation.BOUNCE
    icon: 'http://maps.google.com/mapfiles/marker_green.png'


window.WS.AreaMap = AreaMap