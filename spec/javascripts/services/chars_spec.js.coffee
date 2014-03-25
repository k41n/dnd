#= require spec_helper

describe 'Chars', ->
  beforeEach ->
    @service = @injector.get('Chars')

    @Character = @model('Character')
    @characters = [new @Character({ id: 1, name: 'Кровавый упырь' })]
    @http.whenGET('/api/characters').respond(200, @characters)

    @CharacterAbility = @model('CharacterAbility')
    @character_abilities = [new @CharacterAbility({id: '1', name: 'Знание улиц'})]
    @http.whenGET('/api/character_abilities').respond(200, @character_abilities)

    @http.flush()

  describe 'init', ->
    it 'requests characters on init', ->
      expect(@service.characters).toBeDefined()
      expect(Object.keys(@service.characters).length).toEqual(1)