#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.Counterstrike', ->
  beforeEach ->
    @prepareSkillApis()    

    @character = @Chars.create(2)

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @character.skillInstantiation.promise.then =>
      @skill = @character.skills[9]

  describe 'Character constructor', ->
    it 'can be picked by rogue', ->
      @character.skills = {}
      @character.p.skill_ids = []
      @timeout ->
        expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked unless main weapon is light blade', ->
      @character.skills = {}
      @character.p.skill_ids = []
      @character.weapon = @Weapons.create(1)
      @timeout ->
        expect(@skill.pickable(@character)).toBe(false)      

    it 'cannot be picked twice', ->
      @timeout ->
        expect(@skill.pickable(@character)).toBe(false)

  describe 'toHit roll', ->
    it 'calculates to hit bonus', ->
      # Rogue has dex of 20 and level 1 = 5
      @timeout ->
        expect(@skill.toHitBonus(@character)).toEqual(5)

  describe 'toDamage roll', ->
    it 'equals to character weapon damage (WD) + mod(dex)', ->
      # { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
      @timeout ->
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
      @timeout ->
        spyOn(@skill, 'checkHit').andReturn(true)
        @skill.apply(@character, @monster)
        expect(@monster.affectNames()).toContain "Контратака (Ответный удар) [Жмык в щелку шмыг]"

  describe 'creates debuff which', ->
    it 'strikes back when debuffed creature attacks applicator and misses', ->
      @grid = new Grid()
      @grid.place(@character, {x: 0, y: 0})
      @grid.place(@monster, {x: 1, y: 1})
      @timeout ->
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
      @timeout ->
        @grid = new Grid()
        @grid.place(@character, {x: 0, y: 0})
        @grid.place(@monster, {x: 1, y: 1})
        spyOn(@skill, 'checkHit').andReturn(true)
        @skill.apply(@character, @monster)
        tempSkill = @character.addSkillByJsClass('Skills.CounterstrikeOnAttack')
        # Rogue has strength 12 and level 1 = 1
        expect(tempSkill.toHitBonus(@character)).toEqual(1)

        expect(tempSkill.damageRollDice(@character)).toEqual(4)
        expect(tempSkill.damageRollCount(@character)).toEqual(1)
        # Rogue has str of 12 and level 1 = 1
        expect(tempSkill.damageBonus(@character)).toEqual(1)