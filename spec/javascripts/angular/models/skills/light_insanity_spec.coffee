#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.LightInsanity', ->
  beforeEach ->
    @prepareSkillApis()
    @character = @Chars.create(1)

    @character.skillInstantiation.promise.then =>
      console.log "@character.skills", @character.skills
      @skill = @character.skills[6]

  describe 'Character constructor', ->
    it 'can be picked by paladin', ->
      @timeout ->
        @character.skills = {}
        @character.p.skill_ids = []
        expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked twice', ->
      @timeout ->
        expect(@skill.pickable(@character)).toBe(false)

  describe 'toHit roll', ->
    it 'calculates to hit bonus', ->
      @timeout ->
        # Paladin has cha of 16 and level 1 = 3
        expect(@skill.toHitBonus(@character)).toEqual(3)

  describe 'toDamage roll', ->
    it '3d8 + mod(CHA)', ->
      @timeout ->
        # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
        expect(@character.weapon).toBeDefined()
        expect(@skill.damageRollDice(@character)).toEqual(8)
        expect(@skill.damageRollCount(@character)).toEqual(3)
        # Paladin has str of 16 and level 1 = 3
        expect(@skill.damageBonus(@character)).toEqual(3)

  describe 'on Hit', ->
    it 'in case of hit adds confused debuff on enemy and -2 ac bonus', ->
      @timeout ->
        @grid = new Grid()
        @grid.place(@character, {x: 0, y: 0})
        @grid.place(@monster, {x: 1, y: 1})
        @character.addSkill(@skill)      

        spyOn(@skill, 'checkHit').andReturn(true)

        @skill.apply(@character, @monster)

        expect(@monster.i.acBonus).toEqual(-2)
        expect(@monster.affectNames()).toContain "Изумлен (Световое помешательство) [Яростный кулак]"

    it 'does not stack debuff', ->
      @timeout ->
        @grid = new Grid()
        @grid.place(@character, {x: 0, y: 0})
        @grid.place(@monster, {x: 1, y: 1})
        @character.addSkill(@skill)      

        spyOn(@skill, 'checkHit').andReturn(true)

        @skill.apply(@character, @monster)
        @skill.apply(@character, @monster)

        expect(@monster.i.acBonus).toEqual(-2)

    it 'expires on the end of 2nd applicator turn', ->
      @timeout ->
        @grid = new Grid()
        @grid.place(@character, {x: 0, y: 0})
        @grid.place(@monster, {x: 1, y: 1})
        @character.addSkill(@skill)      

        spyOn(@skill, 'checkHit').andReturn(true)

        @skill.apply(@character, @monster)

        expect(@monster.i.acBonus).toEqual(-2)
        @character.trigger('endOfTurn')
        expect(@monster.i.acBonus).toEqual(-2)
        @character.trigger('endOfTurn')
        expect(@monster.i.acBonus).toEqual(0)
        expect(@monster.affectTypes()).not.toContain "Изумлен (Световое помешательство)"

  describe 'on miss', ->
    it 'brings 1/2 of rolled damage', ->
      @timeout ->
        @grid = new Grid()
        @grid.place(@character, {x: 0, y: 0})
        @grid.place(@monster, {x: 1, y: 1})
        @monster.i.acBonus = 0
        @character.addSkill(@skill)      

        spyOn(@skill, 'checkHit').andReturn(false)
        spyOn(Roll, 'do').andReturn(20)
        expect(@monster.i.hp).toEqual(100)
        @skill.apply(@character, @monster)
        # Damages 1/2
        expect(@monster.i.hp).toEqual(90)
        # Does not decreases AC
        expect(@monster.i.acBonus).toEqual(0)
        expect(@monster.affectNames()).toContain "Изумлен (Световое помешательство) [Яростный кулак]"
