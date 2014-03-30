class window.Grid
  constructor: () ->
    @createCells()
    @creatures = []

    @moveableCells = []

  createCells: ->
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
      creatures: $.map @creatures, (creature) =>
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


  loadFromJSON: (data, Zoo, Chars) =>
    console.log "Loading GRID from", data
    @createCells()
    @creatures = []
    for creatureJSON in data.creatures
      if creatureJSON.type == 'monster'
        creature = Zoo.getById(creatureJSON.id)
        console.log 'creature', creature
        if creature
          creature.loadFromJSON(creatureJSON)
          if creature.location?
            @place creature, creature.location
      else 
        creature = Chars.create(creatureJSON.id)
        creature.location = creatureJSON.location
        if creature.location?
          @place creature, creature.location

    for cellJSON in data.cells
      cell = @get(cellJSON.location)
      cell.loadFromJSON(cellJSON)

  get: (location) =>
    @cells[location.y][location.x]

  place: (creature, location) ->
    @get(location).addCreature creature
    creature.setCoords location, @
    @creatures ||= []
    @creatures.push creature

  deleteMonster: (creature) ->
    index = @creatures.indexOf(creature)
    cell = @get(creature.location)
    cell.creature = null
    @creatures.splice(index, 1)

  move: (creature, location) =>
    @get(creature.location).creature = undefined
    @get(location).creature = creature
    creature.moveTo(location)
    for c in @creatures
      c.trigger 'move',
        moved: creature
        to: location
    @unmarkMoveableCellsForCreature()

  rotate: (creature, direction) =>
    creature.i.rotation = direction

  creaturesInRadius: (location, radius) ->
    $.grep @creatures, (c) =>
      @distance(location, c.location) < radius + 1

  distance: (p1, p2) ->
    dx = p1.x-p2.x
    dy = p1.y-p2.y
    Math.sqrt( dx*dx+dy*dy )

  markMoveableCellsForCreature: (creature) =>
    speed = 5
    position = creature.location
    minX = Math.max(position.x - speed, 0)
    maxX = Math.min(position.x + speed, 24)
    minY = Math.max(position.y - speed, 0)
    maxY = Math.min(position.y + speed, 24)
    for x in [minX..maxX]
      for y in [minY..maxY]
        if ( (Math.abs(x - position.x) + Math.abs(y - position.y) <= speed) )
          location = { x: x, y: y }
          console.log location
          @get(location).moveable = true
          @moveableCells.push @get(location)

  unmarkMoveableCellsForCreature: =>
    if @moveableCells.length > 0
      for i in [0..@moveableCells.length-1]
        @moveableCells[i].moveable = false

  resetAttackHighlight: ->
    for row in @cells
      for cell in row
        cell.attackable = false
