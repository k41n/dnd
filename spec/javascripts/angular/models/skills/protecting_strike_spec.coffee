#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.ProtectingStrike', ->
  beforeEach ->
    stubApiSkills(@http)
    stubApiPerks(@http)
    stubApiWeapons(@http)

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')
    @SkillLibrary = @factory('SkillLibrary')
    @http.flush()

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @character = @CharacterModel.new fixtures.paladin
    @friend = @CharacterModel.new fixtures.rogue

    @skill = new Skills.ProtectingStrike(fixtures.protecting_strike)

  describe 'Character constructor', ->
    it 'can be picked by paladin', ->
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
    it 'equals to double character weapon damage (WD) + mod(CHA)', ->
      @character.addSkill(@skill)      
      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice()).toEqual(8)
      expect(@skill.damageRollCount()).toEqual(2)
      # Paladin has cha of 16 and level 1 = 3
      expect(@skill.damageBonus()).toEqual(3)

  describe 'on hit', ->

    it 'in case of hit adds to paladin skills disposable skill "ProtectiveShield"', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      

      spyOn(@skill, 'checkHit').andReturn(true)

      @buffSkill = new Skills.ProtectiveShield(fixtures.protective_shield)
      spyOn(@character.SkillLibrary, 'getByJsClass').andReturn(@buffSkill)

      @skill.apply(@character, @monster)

      expect(@character.skillIds()).toContain(@buffSkill.id)

  describe 'protective shield', ->

    it 'when paladin has "ProtectiveShield" it can be used only once', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      

      spyOn(@skill, 'checkHit').andReturn(true)

      @buffSkill = new Skills.ProtectiveShield(fixtures.protective_shield)
      spyOn(@character.SkillLibrary, 'getByJsClass').andReturn(@buffSkill)

      @skill.apply(@character, @monster)

      expect(@character.skillIds()).toContain(@buffSkill.id)

      @buffSkill.apply(@character, @friend)
      expect(@friend.i.acBonus).toEqual(3)

      expect(@character.skillIds()).not.toContain(@buffSkill.id)

