#= require spec_helper

describe 'Chars', ->
  beforeEach ->
    @service = @injector.get('Chars')
    @Character = @model('Character')
    @characters = [new @Character({ id: 1, name: 'Кровавый упырь' })]

    @http.whenGET('/api/characters').respond(200, @characters)
    @http.flush()

  describe 'init', ->
    it 'requests characters on init', ->
      expect(@service.characters).toBeDefined()
      expect(@service.characters.length).toEqual(1)