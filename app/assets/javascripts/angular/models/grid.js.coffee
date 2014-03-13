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

    @creatures = []

    @moveableCells = []

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


  loadFromJSON: (data, SkillLibrary) =>
    @creatures = []
    for creatureJSON in data.creatures
      creature = new Creature()
      creature.loadFromJSON(creatureJSON, SkillLibrary)
      if creature.location?
        @place creature, creature.location.x, creature.location.y
    for cellJSON in data.cells
      cell = @get(cellJSON.location.x, cellJSON.location.y)
      cell.loadFromJSON(cellJSON)

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
    @get(creature.location.x, creature.location.y).creature = undefined
    @get(x, y).creature = creature
    creature.moveTo(x, y)
    for c in @creatures
      c.trigger 'move',
        moved: creature
        to:
          x: x
          y: y
    @unmarkMoveableCellsForCreature()

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
    maxX = Math.max(position.x + speed, 24)
    minY = Math.max(position.y - speed, 0)
    maxY = Math.max(position.y + speed, 24)
    for x in [minX..maxX]
      for y in [minY..maxY]
        if ( (Math.abs(x - position.x) + Math.abs(y - position.y) <= speed) )
          @get(x, y).moveable = true
          @moveableCells.push @get(x, y)

  unmarkMoveableCellsForCreature: =>
    if @moveableCells.length > 0
      for i in [0..@moveableCells.length-1]
        @moveableCells[i].moveable = false

  resetAttackHighlight: ->
    for row in @cells
      for cell in row
        cell.attackable = false
