#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.PenetrationStrike', ->
  beforeEach ->
    @prepareSkillApis()

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')

    @character = @CharacterModel.new fixtures.rogue

    @skill = new Skills.PenetrationStrike(fixtures.penetration_strike)
    @http.flush()    

  describe 'Character constructor', ->
    it 'can be picked by rogue', ->
      expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked twice', ->
      @character.addSkill(@skill)
      expect(@skill.pickable(@character)).toBe(false)

  describe 'toHit roll', ->
    it 'calculates to hit bonus', ->
      @character.addSkill(@skill)
      # Rogue has dex of 20 and level 1 = 5
      expect(@skill.toHitBonus(@character)).toEqual(5)

  describe 'toDamage roll', ->
    it 'equals to character weapon damage (WD) + mod(dex)', ->
      @character.addSkill(@skill)      
      # { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(4)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Rogue has dex of 20 and level 1 = 5
      expect(@skill.damageBonus(@character)).toEqual(5)
