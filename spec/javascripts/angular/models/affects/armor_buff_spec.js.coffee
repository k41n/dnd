#= require spec_helper

describe 'Affects.ArmorBuff', ->
  beforeEach ->
    @creature = @model('Creature')
    @buff = @model('Affects.ArmorBuff')

  describe 'application', ->
    it 'can measure distance', ->
      expect(@buff.distance({x: 0,y: 0}, {x: 3, y: 4})).toEqual(5.0)

    it 'applies buff to creature', ->
      expect(@buff).toBeDefined()

      spyOn(@buff, 'trigger').andCallThrough()
      spyOn(@creature, 'registerEventHandler').andCallThrough()

      @buff.applyTo(@creature)

      expect(@creature.affects.length).toEqual(1)

      expect(@buff.trigger).toHaveBeenCalledWith 'applied',
        to: @creature

      expect(@creature.registerEventHandler).toHaveBeenCalled()

    it 'applies buff to neighbors on approach', ->
      @grid = @model('Grid')
      @creature1 = new Creature('Paladin')
      @creature2 = new Creature('Rogue')

      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, 0, 0)
      @grid.place(@creature2, 2, 2) # Too far for buff to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.ac).toEqual(10)

      @grid.move(@creature2, 1, 1) # Distance is 1,41 -> buff affects

      expect(@creature2.ac).toEqual(11)

      @grid.move(@creature2, 2, 2) # Distance is again 2,82 -> buff fades
      expect(@creature2.ac).toEqual(10)

    it 'applies buff to neighbours when cast', ->
      @grid = @model('Grid')
      @creature1 = new Creature('Paladin')
      @creature2 = new Creature('Rogue')

      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, 0, 0)
      @grid.place(@creature2, 1, 1) # Close enough for buff to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.ac).toEqual(11)

    it 'does no reapplies buff on moving in area of action', ->
      @grid = @model('Grid')
      @creature1 = new Creature('Paladin')
      @creature2 = new Creature('Rogue')

      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, 0, 0)
      @grid.place(@creature2, 1, 1) # Close enough for buff to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.ac).toEqual(11)

      @grid.move(@creature2, 1, 0)

      expect(@creature2.ac).toEqual(11)

    it 'does not decreases AC on moving outside area of action', ->
      @grid = @model('Grid')
      @creature1 = new Creature('Paladin')
      @creature2 = new Creature('Rogue')

      expect(@creature1).not.toBe(@creature2)

      @grid.place(@creature1, 0, 0)
      @grid.place(@creature2, 2, 2) # Far enough for buff not to start acting

      @buff.applyTo(@creature1)

      expect(@creature2.ac).toEqual(10)

      @grid.move(@creature2, 10, 10)

      expect(@creature2.ac).toEqual(10)
