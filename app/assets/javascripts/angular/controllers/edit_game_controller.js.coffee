class window.EditGameController
  constructor: (@$scope, $routeParams, @Game, @Combats, @Combat, @$injector, @$modal, @Faye, @$location) ->
    @$scope.c = @    
    @$scope.combats = {}
    @subscribeToFaye()
    @$scope.game = Game.get { id: $routeParams.id }, =>
      @fetchCombats()

  fetchCombats: ->
    console.log "@$scope.game.id = ", @$scope.game.id
    combats = @Combats.query { gameId: @$scope.game.id }, =>
      for combat in combats
        @$scope.combats[combat.id] = combat

  showNewCombatDialog: ->
    modalInstance = @$modal.open
      templateUrl: '/new_combat_dialog.html'
      controller: 'NewCombatDialogController'
    modalInstance.result.then (requisites) =>
      @createCombat(requisites)

  createCombat: (data) ->
    c = new @Combats(combat: data)
    c.$save { gameId: @$scope.game.id } # On success faye broadcast will be fired

  showDeleteCombatDialog: (game) =>
    modalInstance = @$modal.open
      templateUrl: '/delete_combat_dialog.html'
      controller: 'DeleteCombatDialogController'
    modalInstance.result.then (requisites) =>
      @destroyCombat(game)

  onCombatUpdated: (data) =>
    @$scope.combats[data.id] = data

  onCombatDeleted: (data) =>
    delete @$scope.combats[data.id]

  editCombat: (combat) =>
    @$location.path("/games/#{@$scope.game.id}/combats/#{combat.id}")

  destroyCombat: (combat) =>
    c = new @Combat(combat: combat)
    c.$delete 
      id: combat.id
      gameId: @$scope.game.id

  subscribeToFaye: =>
    if @Faye?
      @Faye.subscribe "/combats", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'created' || msg.type == 'updated'
          @onCombatUpdated(msg.combat)
        if msg.type == 'deleted'
          @onCombatDeleted(msg.combat)

EditGameController.$inject = ["$scope", "$routeParams", "Game", "Combats", "Combat", "$injector", "$modal", "Faye", "$location"]

angular.module("dndApp").controller("EditGameController", EditGameController)