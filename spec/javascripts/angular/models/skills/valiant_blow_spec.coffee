#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.ValiantBlow', ->
  beforeEach ->
    @prepareSkillApis()

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @character = @CharacterModel.new fixtures.paladin

    @skill = new Skills.ValiantBlow(fixtures.valiant_blow)
    @http.flush()    

  describe 'Character constructor', ->
    it 'can be picked by paladin', ->
      expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked twice', ->
      @character.addSkill(@skill)
      expect(@skill.pickable(@character)).toBe(false)

  describe 'toHit roll', ->
    it 'calculates to hit bonus', ->
      @character.addSkill(@skill)
      # Paladin has str of 18 and level 1 = 4
      expect(@skill.toHitBonus(@character)).toEqual(4) 

    it 'gives +1 to hit bonus when there are monsters nearby', ->
      @character.addSkill(@skill)

      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      expect(@skill.toHitBonus(@character)).toEqual(4)

      @grid.place(@monster, {x: 1, y: 1})
      expect(@skill.toHitBonus(@character)).toEqual(5)      
  
  describe 'toDamage roll', ->
    it 'equals to character weapon damage (WD) + mod(STR)', ->
      @character.addSkill(@skill)      
      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(8)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Paladin has str of 18 and level 1 = 4
      expect(@skill.damageBonus(@character)).toEqual(4)
