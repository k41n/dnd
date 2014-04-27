#= require spec_helper
#= require fixtures/api
#= require fixtures/skills
#= require fixtures/perks

describe 'Perks.WeaponFocus', ->
  beforeEach ->
    stubApiSkills(@http)
    stubApiPerks(@http)
    stubApiWeapons(@http)
    stubApiRaces(@http)
    stubApiCharacterAbilities(@http)    
    stubApiCharacterClasses(@http)    

    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')

    @character = @CharacterModel.new fixtures.paladin

    @perk = new Perks.WeaponFocus(fixtures.weapon_focus)

    @http.flush()    

  describe 'Character constructor', ->
    it 'can be picked', ->
      expect(@perk.pickable(@character)).toBe(true)

    it 'cannot be picked twice', ->
      @character.addPerk(@perk)
      expect(@perk.pickable(@character)).toBe(false)

  describe 'configurable', ->
    it 'can store and load configuration', ->
      config = { weapon_group: 'Легкие клинки'}

      @perk.configure config
        
      expect(@perk.configuration()).toEqual(config)

  describe 'adds to skill damage bonus', ->
    it 'adds +1 to damage when corresponding weapon group weapon is used', ->
      @skill = new Skills.ValiantBlow(fixtures.valiant_blow)
      @character.addSkill(@skill)

      config = { weapon_group: 'Тяжелые клинки'}
      @perk.configure config
      @character.addPerk(@perk)

      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(8)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Paladin has str of 18 and level 1 = 4 + 1 for weapon focus
      expect(@skill.damageBonus(@character)).toEqual(5)

    it 'does not add +1 to damage when corresponding weapon group weapon is not used', ->
      @skill = new Skills.ValiantBlow(fixtures.valiant_blow)
      @character.addSkill(@skill)

      config = { weapon_group: 'Легкие клинки'}
      @perk.configure config
      @character.addPerk(@perk)

      # { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}
      expect(@character.weapon).toBeDefined()
      expect(@skill.damageRollDice(@character)).toEqual(8)
      expect(@skill.damageRollCount(@character)).toEqual(1)
      # Paladin has str of 18 and level 1 = 4 + 0 for weapon focus as weapon group is incorrect
      expect(@skill.damageBonus(@character)).toEqual(4)
