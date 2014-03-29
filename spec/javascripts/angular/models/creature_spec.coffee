#= require spec_helper
#= require fixtures/api

describe 'Creature', ->
  beforeEach ->
    stubApiSkills(@http)
    stubApiMonsters(@http)

    @Creature = @factory('Creature')
    @creature = @Creature.new
      id: 3
      ac: 100
      name: 'Evil paladin'
      description: 'Evil paladin is so evil'
      avatar_url: 'http://fc02.deviantart.net/fs71/i/2010/338/0/b/presenting_the_evil_dragoness_by_paladin095-d348gvr.jpg'

  describe 'constructor', ->
    it 'creates creature', ->
      expect(@creature).toBeDefined()

  describe 'save, load', ->
    it 'can saveload fromto JSON', ->
      json = @creature.saveToJSON()

      @creature2 = @Creature.new()
      @creature2.loadFromJSON(json)

      expect(@creature2.i.ac).toEqual(100)
      expect(@creature2.i.name).toEqual(@creature.p.name)
      expect(@creature2.i.description).toEqual(@creature.p.description)
      expect(@creature2.i.avatar_url).toEqual(@creature.p.avatar_url)


