#= require spec_helper

describe 'Creature', ->
  beforeEach ->
    @creature = new Creature
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

      @creature2 = new Creature()
      @creature2.loadFromJSON(json)

      expect(@creature2.data.ac).toEqual(100)
      expect(@creature2.data.name).toEqual(@creature.data.name)
      expect(@creature2.data.description).toEqual(@creature.data.description)
      expect(@creature2.data.avatar_url).toEqual(@creature.data.avatar_url)


