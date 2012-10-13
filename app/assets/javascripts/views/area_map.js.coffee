# Dependencies: gmaps

class AreaMap

  gmap = null

  defaults:
    mapTypeControl: false
    panControl: false

  constructor: (opts = {}) ->
    @gmap = new GMaps(_.extend(@defaults, opts))


window.WeSpruce.AreaMap = AreaMap