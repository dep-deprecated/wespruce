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
    google.maps.event.addDomListener( @gmap.map, 'dblclick', @newProjectDrop )

  addMarkers: (projects) ->
    for project in projects
      marker = new WS.ProjectMarker(@gmap, project)

  stopNewProjectDrag: (evt) =>
    @draggingNewProject = false

  allowDrop: (evt) =>
    evt.preventDefault()

  newProjectDrop: (evt) =>
    lat = evt.latLng.lat()
    lng = evt.latLng.lng()
    @gmap.addMarker(_.extend(@new_project_opts, {lat: lat, lng: lng}))
    setTimeout(((evt) => @createNewProject(lat, lng)), 600)

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