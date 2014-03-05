#= require spec_helper

describe 'Grid', ->
  beforeEach ->
    @grid = @model('Grid')

  describe 'constructor', ->
    it 'creates grid', ->
      expect(@grid).toBeDefined()

    it 'has 25x25 cells', ->
      expect(@grid.cells.length).toEqual(25)
      expect(@grid.cells[0].length).toEqual(25)

  describe 'creature placement', ->
    it 'can place creature on grid', ->
      @creature = @model('Creature')
      @grid.place @creature, 0, 0
      expect(@creature.location).toEqual {x: 0, y: 0}

  describe 'creature moving', ->
    it 'can move creature', ->
      @creature = @model('Creature')
      @grid.place @creature, 0, 0
      expect(@creature.location).toEqual {x: 0, y: 0}

      @grid.move(@creature, 1, 1)
      expect(@creature.location).toEqual {x: 1, y: 1}
      expect(@grid.cells[0][0]).toBeUndefined()
      expect(@grid.cells[1][1]).toEqual(@creature)

    it 'triggers move event on all creatures', ->
      @creature1 = @model('Creature')
      @creature2 = @model('Creature')
      @grid.place @creature1, 0, 0
      @grid.place @creature2, 0, 1

      spyOn(@creature2, 'event')

      @grid.move(@creature1, 1, 1)

      expect(@creature2.event).toHaveBeenCalledWith 'move',
        moved: @creature1
        to:
          x: 1
          y: 1
