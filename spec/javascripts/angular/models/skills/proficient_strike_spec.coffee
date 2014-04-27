#= require spec_helper
#= require fixtures/monsters
#= require fixtures/skills
#= require fixtures/api

describe 'Skills.ProficientStrike', ->
  beforeEach ->
    @prepareSkillApis()    

    @CharacterModel = @factory('CharacterModel')
    @character = @CharacterModel.new(fixtures.rogue)

    @Creature = @factory('Creature')
    @monster = @Creature.new fixtures.goblin
    @monster.hostile = true

    @Weapons = @factory('Weapons')
    @Chars = @factory('Chars')
    @SkillLibrary = @factory('SkillLibrary')

    @skill = new Skills.ProficientStrike(fixtures.proficient_strike)

    @http.flush()          

  describe 'Character constructor', ->
    it 'can be picked by rogue', ->
      expect(@skill.pickable(@character)).toBe(true)

    it 'cannot be picked unless main weapon is light blade', ->
      @character.weapon = @Weapons.create(1)
      expect(@skill.pickable(@character)).toBe(false)      

  describe 'allows move on 2 cells before application', ->
    it 'highlight targets also highlights cells in radius 2 as moveable', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @character.addSkill @skill
      @skill.highlightTargets(@grid, @character)

      # Can move from 0,0 to 1,0 before attack
      expect(@grid.get({x: 1, y: 0}).moveable).toBe(true)

    it 'does not allow moving twice per turn', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @character.addSkill @skill
      @skill.highlightTargets(@grid, @character)
      @skill.onUsageStart()

      @grid.move @character, {x: 1, y: 0}
      @skill.highlightTargets(@grid, @character)
      @skill.onUsageStart()
      expect(@grid.get({x: 0, y: 0}).moveable).toBe(false)

  describe 'save load via JSON', ->
    it 'saves its state', ->
      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}
      @character.addSkill @skill
      @skill.highlightTargets(@grid, @character)
      @skill.onUsageStart()

      @grid.move @character, {x: 1, y: 0}

      json = @skill.saveToJSON()

      @skill2 = new Skills.ProficientStrike(fixtures.counterstrike)
      @skill2.loadFromJSON(json)

      expect(@skill2.moved).toBe(true)

    it 'saves and loads its state on grid reload', ->
      @character.addSkill @skill

      @grid = new Grid()
      @grid.place @character, {x: 0, y: 0}

      console.log "@character.skills", @character.skills
      @skill.highlightTargets(@grid, @character)
      console.log "Event handlers", @character.eventHandlers
      @skill.onUsageStart()
      console.log "Event handlers", @character.i.id
      console.log "Event handlers", @skill.char.i.id

      @grid.move @character, {x: 1, y: 0}
      expect(@skill.moved).toBe(true)
      # Now skill state is "moved"

      json = @grid.saveToJSON()
      console.log json

      @grid2 = new Grid()
      @grid2.loadFromJSON(json, @Zoo, @Chars, @SkillLibrary)
      @cell = @grid2.get {x: 1, y: 0}
      expect(@cell).toBeDefined()
      @charLoaded = @cell.creature
      expect(@charLoaded).toBeDefined()
      expect(@charLoaded.skills).toBeDefined()
      expect(Object.keys(@charLoaded.skills).length).toEqual(1)
      console.log @charLoaded.skills
      @skill = @charLoaded.skills[11]
      expect(@skill.moved).toBe(true)