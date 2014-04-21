#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.RighteousJudgement', ->
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

    @skill = new Skills.RighteousJudgement(fixtures.righteous_judgement)

  describe 'Character constructor', ->
    it 'cannot be picked by paladin on level 1', ->
      @character.p.level = 1
      expect(@skill.pickable(@character)).toBe(false)

    it 'can be picked by paladin on level 3', ->
      @character.p.level = 3
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
    it 'equals to double character weapon damage (2WD) + mod(CHA)', ->
      @character.addSkill(@skill)      
      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice()).toEqual(8)
      expect(@skill.damageRollCount()).toEqual(2)
      # Paladin has cha of 16 and level 1 = 3
      expect(@skill.damageBonus()).toEqual(3)

  describe 'on hit', ->

    it 'adds to temp hp 5+mod(WIS) to paladin and his friends in 5 cells area', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      @grid.place(@friend, {x: 1, y: 0})
      @friend.i.tempHp = 0

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @monster)

      expect(@character.i.tempHp).toEqual(5 + @character.mod('wis'))
      expect(@friend.i.tempHp).toEqual(5 + @character.mod('wis'))

    it 'do not adds to temp hp to paladin friends outside 5 cells area', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      @grid.place(@friend, {x: 10, y: 10})
      @friend.i.tempHp = 0

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @monster)

      expect(@character.i.tempHp).toEqual(5 + @character.mod('wis'))
      expect(@friend.i.tempHp).toEqual(0)
