#= require spec_helper
#= require fixtures/api

describe 'Chars', ->
  beforeEach ->
    @service = @injector.get('Chars')

    @characters = [ { id: 1, name: 'Кровавый упырь' } ]
    @http.whenGET('/api/characters').respond(200, @characters)

    @CharacterAbility = @model('CharacterAbility')
    @character_abilities = [new @CharacterAbility({id: '1', name: 'Знание улиц'})]
    @http.whenGET('/api/character_abilities').respond(200, @character_abilities)

    stubApiPerks(@http)
    stubApiSkills(@http)
    stubApiWeapons(@http)

    @http.flush()

  describe 'init', ->
    it 'requests characters on init', ->
      expect(@service.characters).toBeDefined()
      expect(Object.keys(@service.characters).length).toEqual(1)

    it 'fills character permanent data', ->
      expect(@service.characters[1].p.name).toEqual(@characters[0].name)