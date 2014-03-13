#= require spec_helper

describe 'Grid', ->
  beforeEach ->
    @grid = new Grid()
    @zeroLocation = {x: 0, y: 0}
    @SkillLibrary = @injector.get('SkillLibrary')
    @Zoo = @injector.get('Zoo')

    @Monster = @model('Monster')
    @monsters = [new @Monster({ id: 1, name: 'Кровавый упырь' })]
    @http.whenGET('/api/monsters').respond(200, @monsters)

    @Skill = @model('Skill')
    @skills = [new @Skill({ id: 1, title: 'Удар ногой с разворота' })]
    @http.whenGET('/api/skills').respond(200, @skills)

    @http.flush()


  describe 'constructor', ->
    it 'creates grid', ->
      expect(@grid).toBeDefined()

    it 'has 25x25 cells', ->
      expect(@grid.cells.length).toEqual(25)
      expect(@grid.cells[0].length).toEqual(25)

  describe 'creature placement', ->
    it 'can place creature on grid', ->
      @creature = new Creature()
      @grid.place @creature, @zeroLocation
      expect(@creature.location).toEqual @zeroLocation

  describe 'creature moving', ->
    it 'can move creature', ->
      @creature = new Creature()
      @grid.place @creature, @zeroLocation
      expect(@creature.location).toEqual @zeroLocation

      @grid.move(@creature, {x: 1, y: 1})
      expect(@creature.location).toEqual {x: 1, y: 1}
      expect(@grid.cells[0][0].creature).toBeUndefined()
      expect(@grid.cells[1][1].creature).toEqual(@creature)

    it 'triggers move event on all creatures', ->
      @creature1 = new Creature()
      @creature2 = new Creature()
      @grid.place @creature1, @zeroLocation
      @grid.place @creature2, {x: 0, y: 1}

      expect(@creature1).not.toBe(@creature2)

      spyOn(@creature2, 'trigger')

      @grid.move(@creature1, {x: 1, y: 1})

      expect(@creature2.trigger).toHaveBeenCalledWith 'move',
        moved: @creature1
        to:
          x: 1
          y: 1

  describe 'save and load', ->
    it 'can save and load to json', ->
      @creature = new Creature
        id: 1
      @grid.place @creature, @zeroLocation
      @grid.get({x: 9, y: 8}).moveability = 1

      @grid2 = new Grid()

      json = @grid.saveToJSON()
      @Zoo.loading.$promise.then =>
        @grid2.loadFromJSON(json, @SkillLibrary, @Zoo)
        expect(@grid2.creatures.length).toEqual(1)
        console.log @grid2.get({x: 9, y: 8})
        expect(@grid2.get({x: 9, y: 8}).moveability).toEqual(1)

