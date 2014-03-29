class window.GamesController
  constructor: (@$scope, @Game, @$injector, @$modal, @Faye, @$location, @current_user) ->
    @$scope.c = @    
    @$scope.games = {}    
    @page = 1
    @subscribeToFaye()
    @nextPage()

  nextPage: =>
    return if @nextPageBeingRequested
    @nextPageBeingRequested = true
    games = @Game.query
      page: @page
    , =>
      @page += 1
      for game in games
        @$scope.games[game.id] = game
      @nextPageBeingRequested = false

  showNewGameDialog: =>
    modalInstance = @$modal.open
      templateUrl: '/new_game_dialog.html'
      controller: 'NewGameDialogController'
    modalInstance.result.then (requisites) =>
      @createGame(requisites)

  showDeleteGameDialog: (game) =>
    modalInstance = @$modal.open
      templateUrl: '/delete_game_dialog.html'
      controller: 'DeleteGameDialogController'
    modalInstance.result.then (requisites) =>
      @destroyGame(game)

  createGame: (data) =>
    game = new @Game(game: data)
    game.$save {} # On success faye broadcast will be fired

  destroyGame: (game) =>
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

GamesController.$inject = ["$scope", "Game", "$injector", "$modal", "Faye", "$location", "current_user"]

angular.module("dndApp").controller("GamesController", GamesController)