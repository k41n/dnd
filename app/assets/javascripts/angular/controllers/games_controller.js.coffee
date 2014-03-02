class window.GamesController
  constructor: (@$scope, @Game, @$injector, @$modal, @Faye, @$location) ->
    @$scope.c = @    
    @$scope.games = {}    
    @fetchGames()
    @subscribeToFaye()

  fetchGames: =>
    games = @Game.query {}, =>
      for game in games
        console.log game
        @$scope.games[game.id] = game

  showNewGameDialog: =>
    modalInstance = @$modal.open
      templateUrl: '/new_game_dialog.html'
      controller: 'NewGameDialogController'
    modalInstance.result.then (requisites) =>
      @createGame(requisites)

  showDeleteGameDialog: (game) =>
    console.log 'showDeleteGameDialog'
    modalInstance = @$modal.open
      templateUrl: '/delete_game_dialog.html'
      controller: 'DeleteGameDialogController'
    modalInstance.result.then (requisites) =>
      @destroyGame(game)

  createGame: (data) =>
    console.log "Creating game"
    game = new @Game(game: data)
    game.$save {} # On success faye broadcast will be fired

  destroyGame: (game) =>
    console.log "Destroying game", game
    g = new @Game(game: game)
    g.$delete 
      id: game.id

  onGameUpdated: (data) =>
    @$scope.games[data.id] = data

  onGameDeleted: (data) =>
    delete @$scope.games[data.id]

  editGame: (game) =>
    @$location.path("/games/#{game.id}")

  subscribeToFaye: =>
    if @Faye?
      @Faye.subscribe "/games", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'created' || msg.type == 'updated'
          @onGameUpdated(msg.game)
        if msg.type == 'deleted'
          @onGameDeleted(msg.game)

GamesController.$inject = ["$scope", "Game", "$injector", "$modal", "Faye", "$location"]

angular.module("dndApp").controller("GamesController", GamesController)