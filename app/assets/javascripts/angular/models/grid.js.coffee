class window.Grid
  constructor: () ->
    @cells = [0...25].map (x)->
      [0...25].map (y) ->
        new Cell()

    x = 0
    y = 0
    for row in @cells
      for cell in row
        cell.location = 
          x: x
          y: y
        x += 1
      y += 1
      x = 0

    @rows = [0...25].map (x) =>
      @cells[x]

  saveToJSON: =>
    {
      creatures: $.map @creatures, (creature) ->
        creature.saveToJSON()
      cells: @cellsJSON()
    }

  cellsJSON: =>
    ret = []
    for row in @cells
      for cell in row
        if cell.moveability
          ret.push
            location: cell.location
            moveability: cell.moveability
    ret


  loadFromJSON: (data) =>
    @creatures = []
    for creatureJSON in data.creatures
      creature = new Creature()
      creature.loadFromJSON(creatureJSON)
      if creature.location?
        @place creature, creature.location.x, creature.location.y
    for cellJSON in data.cells
      cell = @get(cellJSON.location.x, cellJSON.location.y)
      cell.loadFromJSON(cellJSON)
      console.log cell

  get: (x,y) =>
    @cells[y][x]

  place: (creature, x, y) =>
    @cells[y][x].addCreature creature
    creature.setCoords x, y, @
    @creatures ||= []
    @creatures.push creature

  deleteMonster: (creature) ->
    index = @creatures.indexOf(creature)
    cell = @get(creature.location.x, creature.location.y)
    cell.creature = null
    @creatures.splice(index, 1)

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

  markMoveableCellsForCreature: (creature) =>
    #i cant complete my algorythm now. Will do it later.
#    position = creature.location
#    speed = 5
#    startCol = position.x - speed
#    steps = speed*2 + 1
#    height = 1
#    console.log creature
#    console.log @rows
#    console.log @cells
#
#    for step in [1..steps]
#      tile = @cells[position.x][startCol]
#      if tile
#        tile.moveable = true
##        moveableTiles.push tile
#        if height >= 3
#          startRow = tile.x - Math.floor(height/2)
#          for j in [1..height]
#            vertTile = tileSet[startRow]
#            if vertTile
#              vertTile = tileSet[startRow][tile.col]
#              vertTile.moveable = true
#              moveableTiles.push vertTile
#              vertTile = null
#            startRow += 1
#      startCol += 1
#
#      if step*2 > steps then height -= 2 else height += 2


Grid.$inject = ['Cell']

angular.module("dndApp").factory("Grid", -> new Grid())