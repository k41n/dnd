#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api
#= require fixtures/perks

describe 'Skills.MovingStrike', ->
  beforeEach ->
    @prepareSkillApis()    

    @character = @CharacterModel.new(fixtures.rogue)

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @skill = new Skills.MovingStrike(fixtures.moving_strike)

    @http.flush()          

  describe 'Character constructor', ->
    it 'can be picked by rogue', ->
      expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked unless main weapon is light blade', ->
      @character.weapon = @Weapons.create(1)
      expect(@skill.pickable(@character)).toBe(false)      

  describe 'toHit roll', ->
    it 'calculates to hit bonus', ->
      @character.addSkill(@skill)
      # Rogue has dex of 20 and level 1 = 5
      expect(@skill.toHitBonus(@character)).toEqual(5)

  describe 'toDamage roll', ->
    it 'equals to character weapon damage (1 * WD) + mod(dex)', ->
      @character.addSkill(@skill)      
      # { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(4)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Rogue has dex of 20 and level 1 = 5
      expect(@skill.damageBonus(@character)).toEqual(5)

  describe 'on hit', ->
    it 'marks cells in range of 2 from the enemy as enemy movable', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @grid.place @monster, {x: 1, y: 0}
      @character.addSkill @skill
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      expect( @grid.get( { x:2, y: 0 } ).enemy_moveable ).toBe(true)
      expect( @grid.get( { x:3, y: 0 } ).enemy_moveable ).toBe(false)

    it 'marks cells in range of 2 + mod(cha) from the enemy as enemy movable for dodge master', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @grid.place @monster, {x: 1, y: 0}
      @character.addSkill @skill

      @perk = new Perks.RogueTactics(fixtures.perks.rogue_tactics)
      @character.addPerk @perk
      @perk.configure 
        stat: 'Мастер уклонения'

      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      expect( @grid.get( { x:3, y: 0 } ).enemy_moveable ).toBe(true)

    it 'adds click callback to cells in range of 2 from the enemy', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @grid.place @monster, {x: 1, y: 0}
      @character.addSkill @skill
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      expect( @grid.get( { x:2, y: 0 } ).click_callback ).toBeDefined()

    it 'moves enemy to cell specified if callback is executed', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @grid.place @monster, {x: 1, y: 0}
      @character.addSkill @skill
      spyOn(@skill, 'checkHit').andReturn(true)
      @skill.apply(@character, @monster)
      expect( @grid.get( { x:2, y: 0 } ).click_callback ).toBeDefined()
      @grid.get( { x:2, y: 0 } ).click_callback({ x:2, y: 0 })
      expect(@monster.location).toEqual({x: 2, y: 0})



