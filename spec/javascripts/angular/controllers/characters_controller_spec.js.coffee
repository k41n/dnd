#= require spec_helper

describe 'CharactersController', ->
  beforeEach ->
    @controller('CharactersController', { $scope: @scope })
    @Character = @model('Character')
    @characters = [new @Character({ id: 1, name: 'Элайя' })]

    @Race = @model('Race')
    @races = [new @Race({ id: 1, name: 'Гоблин' })]

    @http.whenGET('/api/races').respond(200, @races)
    @http.whenGET('/api/characters').respond(200, @characters)
    @http.flush()

  describe 'load', ->
    it 'sets up the list of current characters', ->
      expect(Object.keys(@scope.characters).length).toEqual(1)

  describe 'new character', ->
    it 'can create new character', ->
      @scope.c.createCharacter()
      @http.whenPOST('/api/characters').respond(200, {message: 'success'})
      @http.flush()
