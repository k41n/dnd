#= require spec_helper

describe 'PlayersController', ->
  beforeEach ->
    @controller('PlayersController', { $scope: @scope })
    @Player = @model('Player')
    @players = [new @Player({ id: 1, name: 'Элайя' })]

    @http.whenGET('/api/players').respond(200, @players)
    @http.flush()

  describe 'load', ->
    it 'sets up the list of current players', ->
      expect(@scope.players.length).toEqual(1)