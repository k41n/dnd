#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api
#= require fixtures/perks

describe 'Skills.TorturingStrike', ->
  beforeEach ->
    @prepareSkillApis()    

    @character = @CharacterModel.new(fixtures.rogue)

    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @skill = new Skills.TorturingStrike(fixtures.torturing_strike)

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
    it 'equals to double character weapon damage (2 * WD) + mod(dex)', ->
      @character.addSkill(@skill)      
      # { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(4)
      expect(@skill.damageRollCount(@character)).toEqual(2)
      # Rogue has dex of 20 and level 1 = 5
      expect(@skill.damageBonus(@character)).toEqual(5)

    it 'equals to 2WD + mod(dex) + mod(str) if char has Cruel Cuthroat spec', ->
      @character.addSkill(@skill)
      @perk = new Perks.RogueTactics(fixtures.perks.rogue_tactics)
      @character.addPerk @perk
      @perk.configure 
        stat: 'Жестокий головорез'
      # { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(4)
      expect(@skill.damageRollCount(@character)).toEqual(2)
      # Rogue has dex of 20 and level 1 = 5
      # and str of 12 and level 1 = 1
      # Total 6
      expect(@skill.damageBonus(@character)).toEqual(6)
