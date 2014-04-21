#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.Counterstrike', ->
  beforeEach ->
    @prepareSkillApis()    

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')
    @http.flush()

    @character = @CharacterModel.new fixtures.rogue
    @Weapons = @factory('Weapons')

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @skill = new Skills.Counterstrike(fixtures.counterstrike)

  describe 'Character constructor', ->
    it 'can be picked by rogue', ->
      expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked unless main weapon is light blade', ->
      @character.weapon = @Weapons.create(1)
      expect(@skill.pickable(@character)).toBe(false)      

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

  describe 'on hit', ->
    it 'casts counterstrike from applicator debuff on hit target', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      expect(@monster.affectNames()).toContain "Контратака (Ответный удар) [Жмык в щелку шмыг]"

  describe 'creates debuff which', ->
    it 'strikes back when debuffed creature attacks applicator and misses', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      monsterSkill = new Skills.ValiantBlow({ attack_char_from: 'dex', attack_char_to: 'ac' })

      spyOn(monsterSkill, 'checkHit').andReturn(false)
      @monster.addSkill monsterSkill

      skillSpy = jasmine.createSpyObj('CounterstrikeOnAttack', ['apply'])
      spyOn(@character, 'addSkillByJsClass').andReturn(skillSpy)

      monsterSkill.apply @monster, @character
      expect(skillSpy.apply).toHaveBeenCalled()

    it 'strikes back with special skill', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @character.addSkill(@skill)      
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      tempSkill = @character.addSkillByJsClass('Skills.CounterstrikeOnAttack')
      # Rogue has strength 12 and level 1 = 1
      expect(tempSkill.toHitBonus(@character)).toEqual(1)

      expect(tempSkill.damageRollDice(@character)).toEqual(4)
      expect(tempSkill.damageRollCount(@character)).toEqual(1)
      # Rogue has str of 12 and level 1 = 1
      expect(tempSkill.damageBonus(@character)).toEqual(1)

