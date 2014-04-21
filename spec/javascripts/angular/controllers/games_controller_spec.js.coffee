#= require spec_helper

describe 'GamesController', ->
  beforeEach ->
    @controller('GamesController', { $scope: @scope })
    @Game = @model('Game')
    @games = [new @Game({ id: 1, name: 'Владимир Геббельс' })]

    @http.whenGET('/api/games?page=1').respond(200, @games)
    @http.flush()

  describe 'load', ->
    it 'sets up the list of games', ->
      expect(Object.keys(@scope.games).length).toEqual(1)

  describe 'gelete game', ->
    it 'sends request to backend', ->
      @scope.c.destroyGame(@games[0])      
      @http.whenDELETE('/api/games/1').respond(200)
      @http.flush()

  describe 'faye', ->
    it 'reacts on faye notifying about new game created', ->
      expect(Object.keys(@scope.games).length).toEqual(1)

      newGame = {id: 2, name: 'Питер Фальк'}

      @scope.c.onGameUpdated(newGame)

      expect(Object.keys(@scope.games).length).toEqual(2)

    it 'updates game if it is updated', ->
      newGame = {id: 1, name: 'Питер Фальк'}

      @scope.c.onGameUpdated(newGame)

      expect(Object.keys(@scope.games).length).toEqual(1)
      expect(@scope.games[1].name).toEqual('Питер Фальк')

