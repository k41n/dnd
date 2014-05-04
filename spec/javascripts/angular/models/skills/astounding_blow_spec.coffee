#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.AstoundingBlow', ->
  beforeEach ->
    @prepareSkillApis()

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @character = @CharacterModel.new fixtures.rogue

    @skill = new Skills.AstoundingBlow(fixtures.astounding_blow)
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
    it 'equals to character weapon damage (WD) + mod(DEX)', ->
      @character.addSkill(@skill)
      # { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(4)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Rogue has dex of 20 level 1 = 5
      expect(@skill.damageBonus(@character)).toEqual(5)

    it 'adds dazed debuff on hit until end of character next turn', ->
      @character.addSkill @skill
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply @character, @monster
      expect(@monster.affectNames()).toContain "Изумлен [Жмык в щелку шмыг]"
      expect(@character.hasCombatSuperiorityOver(@monster)).toBe(true)
      @character.trigger('endOfTurn')
      expect(@character.hasCombatSuperiorityOver(@monster)).toBe(true)      
      @character.trigger('endOfTurn')
      expect(@monster.affectTypes()).not.toContain "Изумлен (Изумляющий удар)"
      expect(@character.hasCombatSuperiorityOver(@monster)).toBe(false)
