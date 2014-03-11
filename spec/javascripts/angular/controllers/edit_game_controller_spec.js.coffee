#= require spec_helper

describe 'EditGameController', ->
  beforeEach ->
    @routeParams.id = 1
    @Game = @model('Game')
    @Combat = @model('Combat')
    @game = new @Game({id: 1, name: 'ДНД №1'})

    @controller('EditGameController', { $scope: @scope, $routeParams: @routeParams })

    @combats = [new @Combat({ id: 1, name: 'Махачка за мешок конопли в селе Соплюево' })]

    @http.whenGET('/api/games/1/combats?page=1').respond(200, @combats)
    @http.whenGET('/api/games/1').respond(200, @game)
    @http.flush()

  describe 'load', ->
    it 'sets up the list of combats inside game', ->
      expect(@scope).toBeDefined()
      expect(Object.keys(@scope.combats).length).toEqual(1)
