#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.WeakeningStrike', ->
  beforeEach ->
    stubApiSkills(@http)
    stubApiPerks(@http)
    stubApiWeapons(@http)

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')
    @http.flush()

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @character = @CharacterModel.new fixtures.paladin

    @skill = new Skills.WeakeningStrike(fixtures.weakening_strike)

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
    it 'equals to character weapon damage (WD) + mod(CHA)', ->
      @character.addSkill(@skill)      
      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice()).toEqual(8)
      expect(@skill.damageRollCount()).toEqual(1)
      # Paladin has cha of 16 and level 1 = 3
      expect(@skill.damageBonus()).toEqual(3)

  describe 'on hit', ->

    it 'in case of hit adds -2 attack debuff on enemy', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @monster)

      expect(@monster.toHitBonus()).toEqual(-2)

    it 'does not stack debuff', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @monster)
      @skill.apply(@character, @monster)

      expect(@monster.toHitBonus()).toEqual(-2)

  describe 'on end of next turn of applicator', ->
    it 'debuff disappears', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      

      spyOn(@skill, 'checkHit').andReturn(true)

      @skill.apply(@character, @monster)

      expect(@monster.toHitBonus()).toEqual(-2)

      @character.trigger('endOfTurn')
      expect(@monster.toHitBonus()).toEqual(-2)
      @character.trigger('endOfTurn')
      expect(@monster.toHitBonus()).toEqual(0)
