#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.SacredCircle', ->
  beforeEach ->
    @prepareSkillApis()

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')
    @SkillLibrary = @factory('SkillLibrary')
    @http.flush()

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @character = @CharacterModel.new fixtures.paladin
    @friend = @CharacterModel.new fixtures.rogue

    @skill = new Skills.SacredCircle(fixtures.sacred_circle)

  describe 'Character constructor', ->
    it 'cannot be picked by paladin on level 1', ->
      @character.p.level = 1
      expect(@skill.pickable(@character)).toBe(false)

    it 'can be picked by paladin on level 5', ->
      @character.p.level = 5
      expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked twice', ->
      @character.addSkill(@skill)
      expect(@skill.pickable(@character)).toBe(false)

  describe 'toHit roll', ->
    it 'calculates to hit bonus', ->
      @character.addSkill(@skill)
      # Paladin has cha of 16 and level 1 = 3
      expect(@skill.toHitBonus()).toEqual(3) 

  describe 'toDamage roll', ->
    it '2d6 + mod(CHA)', ->
      @character.addSkill(@skill)      
      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice()).toEqual(6)
      expect(@skill.damageRollCount()).toEqual(2)
      # Paladin has cha of 16 and level 1 = 3
      expect(@skill.damageBonus()).toEqual(3)

  describe 'highlights', ->
    it 'paladin itself as target', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      @grid.place(@friend, {x: 1, y: 0})

      @skill.highlightTargets(@grid, @character)
      expect(@grid.get(@character.location).attackable).toBeTruthy()


  describe 'on hit', ->

    it 'adds defence bonus to all friends who are in 3 radius', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      @grid.place(@friend, {x: 1, y: 0})
      @friend.i.tempHp = 0

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @character)

      expect(@character.i.acBonus).toEqual(1)
      expect(@character.i.willBonus).toEqual(1)
      expect(@character.i.staminaBonus).toEqual(1)      
      expect(@character.i.reactionBonus).toEqual(1)

      expect(@friend.i.acBonus).toEqual(1)
      expect(@friend.i.willBonus).toEqual(1)
      expect(@friend.i.staminaBonus).toEqual(1)      
      expect(@friend.i.reactionBonus).toEqual(1)

    it 'do not adds defence bonus to all friends who are outside 3 radius', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      @grid.place(@friend, {x: 10, y: 10})
      @friend.i.tempHp = 0
      @friend.i.acBonus = 0
      @friend.i.willBonus = 0
      @friend.i.staminaBonus = 0
      @friend.i.reactionBonus = 0

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @character)

      expect(@character.i.acBonus).toEqual(1)
      expect(@character.i.willBonus).toEqual(1)
      expect(@character.i.staminaBonus).toEqual(1)      
      expect(@character.i.reactionBonus).toEqual(1)

      expect(@friend.i.acBonus).toEqual(0)
      expect(@friend.i.willBonus).toEqual(0)
      expect(@friend.i.staminaBonus).toEqual(0)      
      expect(@friend.i.reactionBonus).toEqual(0)

    it 'defence bonus perishes when area left and appears back when area entered', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      @grid.place(@friend, {x: 1, y: 0})
      @friend.i.tempHp = 0

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @character)

      expect(@friend.i.acBonus).toEqual(1)
      expect(@friend.i.willBonus).toEqual(1)
      expect(@friend.i.staminaBonus).toEqual(1)      
      expect(@friend.i.reactionBonus).toEqual(1)

      @grid.move(@friend, {x: 10, y: 10})

      expect(@friend.i.acBonus).toEqual(0)
      expect(@friend.i.willBonus).toEqual(0)
      expect(@friend.i.staminaBonus).toEqual(0)      
      expect(@friend.i.reactionBonus).toEqual(0)

      @grid.move(@friend, {x: 1, y: 1})      

      expect(@friend.i.acBonus).toEqual(1)
      expect(@friend.i.willBonus).toEqual(1)
      expect(@friend.i.staminaBonus).toEqual(1)      
      expect(@friend.i.reactionBonus).toEqual(1)

