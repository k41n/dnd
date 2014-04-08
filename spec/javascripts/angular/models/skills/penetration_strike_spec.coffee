#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.PenetrationStrike', ->
  beforeEach ->
    stubApiSkills(@http)
    stubApiPerks(@http)
    stubApiWeapons(@http)
    stubApiRaces(@http)
    stubApiCharacterAbilities(@http)    
    stubApiCharacterClasses(@http)    
    

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')
    @http.flush()

    @character = @CharacterModel.new fixtures.rogue

    @skill = new Skills.PenetrationStrike(fixtures.penetration_strike)

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
      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(8)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Rogue has dex of 20 and level 1 = 5
      expect(@skill.damageBonus(@character)).toEqual(5)
