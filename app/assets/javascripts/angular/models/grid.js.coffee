class window.Grid
  constructor: () ->
    @cells = [0...25].map (x)->
      [0...25].map (y) ->
        null

  get: (x,y) =>
    @cells[x][y]

  place: (creature, x, y) =>
    @cells[x][y] = creature
    creature.setCoords x, y, @
    @creatures ||= []
    @creatures.push creature

  move: (creature, x, y) =>
    @cells[creature.location.x][creature.location.y] = undefined
    @cells[x][y] = creature
    creature.moveTo(x, y)
    for c in @creatures
      c.event 'move',
        moved: creature
        to:
          x: x
          y: y

  creaturesInRadius: (location, radius) ->
    $.grep @creatures, (c) =>
      @distance(location, c.location) < radius + 1

  distance: (p1, p2) ->
    dx = p1.x-p2.x
    dy = p1.y-p2.y
    Math.sqrt( dx*dx+dy*dy )


Grid.$inject = ['Cell']

angular.module("dndApp").factory("Grid", -> new Grid())