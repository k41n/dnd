class window.Grid
  constructor: () ->
    @createCells()
    @creatures = []

    @moveableCells = []

    @idCounter = 0

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

  saveToJSON: (creatureBand) =>
    {
      creatures: @creaturesJSON()
      cells: @cellsJSON()
      currentTurn: creatureBand.currentTurnNumber() if creatureBand
      idCounter: @idCounter
    }

  creaturesJSON: ->
    ret = []
    for _, c of @creatures
      ret.push c.saveToJSON()
    ret

  creaturesArray: ->
    ret = []
    for _, c of @creatures
      ret.push c
    ret


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
    @idCounter = data.idCounter if data.idCounter
    @createCells()
    @creatures = {}
    @currentTurn ||= if data.currentTurn then data.currentTurn else 0
    for creatureJSON in data.creatures
      if creatureJSON.type == 'monster'
        creature = Zoo.instanceById(creatureJSON.id)
        if creature
          creature.loadFromJSON(creatureJSON)
          if creature.location?
            @place creature, creature.location
      else 
        creature = Chars.create(creatureJSON.id)
        creature.location = creatureJSON.location
        if creature?
          creature.loadFromJSON(creatureJSON)
        if creature.location?
          @place creature, creature.location

    for cellJSON in data.cells
      cell = @get(cellJSON.location)
      cell.loadFromJSON(cellJSON)

  get: (location) =>
    @cells[location.y][location.x]

  place: (creature, location) ->
    @idCounter += 1
    creature.i.id = @idCounter
    @get(location).addCreature creature
    creature.setCoords location, @
    @creatures ||= {}
    @creatures[@idCounter] = creature

  deleteMonster: (creature) ->
    cell = @get(creature.location)
    cell.creature = null
    delete @creatures[creature.i.id]

  move: (creature, location) =>
    @get(creature.location).creature = undefined
    @get(location).creature = creature
    creature.moveTo(location)
    for _, c of @creatures
      c.trigger 'move',
        moved: creature
        to: location
    @unmarkMoveableCellsForCreature()

  rotate: (creature, direction) =>
    creature.i.rotation = direction

  creaturesInRadius: (location, radius) ->
    ret = []
    for _, c of @creatures
      ret.push c if @distance(location, c.location) < radius + 1
    ret

  distance: (p1, p2) ->
    dx = p1.x-p2.x
    dy = p1.y-p2.y
    Math.sqrt( dx*dx+dy*dy )

  markMoveableCellsForCreature: (creature, speed) =>
    speed ||= creature.p.speed
    position = creature.location
    minX = Math.max(position.x - speed, 0)
    maxX = Math.min(position.x + speed, 24)
    minY = Math.max(position.y - speed, 0)
    maxY = Math.min(position.y + speed, 24)
    for x in [minX..maxX]
      for y in [minY..maxY]
        if ( (Math.abs(x - position.x) + Math.abs(y - position.y) <= speed) )
          location = { x: x, y: y }
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
