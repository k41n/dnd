#= require spec_helper
#= require fixtures/chars
#= require fixtures/api

describe 'Affects.ArmorBuff', ->
  beforeEach ->

    stubApiSkills(@http)
    stubApiPerks(@http)
    stubApiWeapons(@http)
    stubApiRaces(@http)

    @CharacterModel = @factory('CharacterModel')

    @http.flush()

    @creature1 = @CharacterModel.new(fixtures.paladin)
    @creature2 = @CharacterModel.new(fixtures.rogue)

    @buff = new Affects.ArmorBuff()
    @grid = new Grid()

  describe 'application', ->
    it 'can measure distance', ->
      expect(@buff.distance({x: 0,y: 0}, {x: 3, y: 4})).toEqual(5.0)

    it 'applies buff to creature', ->
      expect(@buff).toBeDefined()

      spyOn(@buff, 'trigger').andCallThrough()
      spyOn(@creature1, 'registerEventHandler').andCallThrough()

      @buff.applyTo(@creature1)

      expect(@creature1.affects.length).toEqual(1)

      expect(@buff.trigger).toHaveBeenCalledWith 'applied',
        to: @creature1

      expect(@creature1.registerEventHandler).toHaveBeenCalled()

    it 'applies buff to neighbors on approach', ->
      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, {x :0, y: 0})
      @grid.place(@creature2, {x: 2, y: 2}) # Too far for buff to start acting
      expect(@creature2.location).toEqual 
        x: 2
        y: 2

      @buff.applyTo(@creature1)
      expect(@creature2.i.ac).toEqual(10)
      @grid.move(@creature2, {x: 1, y: 1}) # Distance is 1,41 -> buff affects

      expect(@creature2.i.ac).toEqual(11)

      @grid.move(@creature2, {x: 2, y: 2}) # Distance is again 2,82 -> buff fades
      expect(@creature2.i.ac).toEqual(10)

    it 'applies buff to neighbours when cast', ->
      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, {x: 0, y: 0})
      @grid.place(@creature2, {x: 1, y: 1}) # Close enough for buff to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.i.ac).toEqual(11)

    it 'does not reapplies buff on moving in area of action', ->
      expect(@creature1).not.toBe(@creature2)
      console.log '@creature2', @creature2
      @grid.place(@creature1, {x: 0, y: 0})
      @grid.place(@creature2, {x: 1, y: 1}) # Close enough for buff to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.i.ac).toEqual(11)

      @grid.move(@creature2, {x: 1, y: 0})

      expect(@creature2.i.ac).toEqual(11)

    it 'does not decreases AC on moving outside area of action', ->
      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, {x: 0, y: 0})
      @grid.place(@creature2, {x: 2, y: 2}) # Far enough for buff not to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.i.ac).toEqual(10)

      @grid.move(@creature2, {x: 10, y: 10})

      expect(@creature2.i.ac).toEqual(10)
