#= require spec_helper

describe 'Creature', ->
  beforeEach ->
    @creature = new Creature()

  describe 'constructor', ->
    it 'creates creature', ->
      expect(@creature).toBeDefined()

  describe 'save, load', ->
    it 'can saveload fromto JSON', ->
      @creature.ac = 100
      @creature.name = 'Evil paladin'
      @creature.description = 'Evil paladin is so evil'
      @creature.avatar_url = 'http://fc02.deviantart.net/fs71/i/2010/338/0/b/presenting_the_evil_dragoness_by_paladin095-d348gvr.jpg'
      json = @creature.saveToJSON()

      @creature2 = new Creature()
      @creature2.loadFromJSON(json)

      expect(@creature2.ac).toEqual(100)
      expect(@creature2.name).toEqual(@creature.name)
      expect(@creature2.description).toEqual(@creature.description)
      expect(@creature2.avatar_url).toEqual(@creature.avatar_url)


