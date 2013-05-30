var AreaMap,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

AreaMap = (function() {
  var gmap;

  gmap = null;

  AreaMap.prototype.defaults = {
    mapTypeControl: false,
    panControl: false,
    disableDoubleClickZoom: true
  };

  function AreaMap(opts, projects) {
    if (opts == null) {
      opts = {};
    }
    if (projects == null) {
      projects = [];
    }
    this.cancelProject = __bind(this.cancelProject, this);

    this.newProjectDrop = __bind(this.newProjectDrop, this);

    this.allowDrop = __bind(this.allowDrop, this);

    this.stopNewProjectDrag = __bind(this.stopNewProjectDrag, this);

    this.gmap = new GMaps(_.extend(this.defaults, opts));
    this.gatherNodes();
    this.registerEvents();
    this.addMarkers(projects);
  }

  AreaMap.prototype.gatherNodes = function() {
    this.$new_project_marker = $('#new_project_marker');
    return this.$new_project_form = $('#new_project_form');
  };

  AreaMap.prototype.registerEvents = function() {
    return google.maps.event.addDomListener(this.gmap.map, 'dblclick', this.newProjectDrop);
  };

  AreaMap.prototype.addMarkers = function(projects) {
    var marker, project, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = projects.length; _i < _len; _i++) {
      project = projects[_i];
      _results.push(marker = new WS.ProjectMarker(this.gmap, project));
    }
    return _results;
  };

  AreaMap.prototype.stopNewProjectDrag = function(evt) {
    return this.draggingNewProject = false;
  };

  AreaMap.prototype.allowDrop = function(evt) {
    return evt.preventDefault();
  };

  AreaMap.prototype.newProjectDrop = function(evt) {
    var lat, lng,
      _this = this;
    lat = evt.latLng.lat();
    lng = evt.latLng.lng();
    this.newProjectMarker = this.gmap.addMarker(_.extend(this.new_project_opts, {
      lat: lat,
      lng: lng
    }));
    return setTimeout((function(evt) {
      return _this.createNewProject(lat, lng);
    }), 800);
  };

  AreaMap.prototype.createNewProject = function(lat, lng) {
    var $form;
    $form = this.$new_project_form;
    $form.find('[name="project[latitude]"]').val(lat);
    $form.find('[name="project[longitude]"]').val(lng);
    $form.modal({
      backdrop: 'static',
      keyboard: true
    });
    $form.find('.btn-cancel').on('click', this.cancelProject);
    return $form.on('hidden', function(evt) {
      return $form.find('.btn-cancel').off('click');
    });
  };

  AreaMap.prototype.cancelProject = function(evt) {
    this.$new_project_form.modal('hide');
    return this.newProjectMarker.setVisible(false);
  };

  AreaMap.prototype.new_project_opts = {
    animation: google.maps.Animation.DROP,
    icon: 'http://maps.google.com/mapfiles/marker_green.png'
  };

  return AreaMap;

})();

window.WS.AreaMap = AreaMap;
