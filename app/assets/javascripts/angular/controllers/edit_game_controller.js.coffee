class window.EditGameController
  constructor: (@$scope, $routeParams, @Game, @Combats, @Combat, @$injector, @$modal, @Faye, @$location, @Chars) ->
    @$scope.c = @    
    @$scope.combats = {}
    @subscribeToFaye()
    @page = 1
    @$scope.game = Game.get { id: $routeParams.id }, =>
      @nextPage()
      @Chars.loading.$promise.then =>
        @assignInvitedCharacters()
        @assignAssignedCharacters()

  assignInvitedCharacters: ->
    if @$scope.game.invitedCharacters?
      @$scope.game.invitedCharacters = $.map @$scope.game.invitedCharacters, (c) =>
        @Chars.characters[c.id]

  assignAssignedCharacters: ->
    if @$scope.game.assignedCharacters?
      @$scope.game.assignedCharacters = $.map @$scope.game.assignedCharacters, (c) =>
        @Chars.characters[c.id]

  nextPage: ->
    return if @nextPageBeingRequested    
    return unless @$scope.game.id?
    @nextPageBeingRequested = true    
    combats = @Combats.query { gameId: @$scope.game.id, page: @page }, =>
      for combat in combats
        @$scope.combats[combat.id] = combat
      @page += 1 
      @nextPageBeingRequested = false

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
    @$location.path("/games/#{@$scope.game.id}/combats/#{combat.id}/edit")

  showCombat: (combat) =>
    @$location.path("/games/#{@$scope.game.id}/combats/#{combat.id}")

  destroyCombat: (combat) =>
    c = new @Combat(combat: combat)
    c.$delete 
      id: combat.id
      gameId: @$scope.game.id

  inviteCharacter: (name) ->
    @Chars.inviteByName(name, @$scope.game).then (data) =>
      invitedChar = @Chars.findByName(name)
      @$scope.game.invitedCharacters.push invitedChar if invitedChar 
      @$scope.successMessage = "Invited #{name} to #{@$scope.game.name}"
    , (data) =>
      @$scope.errorMessage = 'Already invited'

  uninviteCharacter: (name) ->
    @Chars.uninviteByName(name, @$scope.game).then (data) =>
      invitedChar = @Chars.findByName(name)
      if invitedChar
        index = @$scope.game.invitedCharacters.indexOf(invitedChar)
        @$scope.game.invitedCharacters.splice(index, 1)
        @$scope.successMessage = "Uninvited #{name} to #{@$scope.game.name}"
    , (data) =>
      @$scope.errorMessage = 'Not invited'

  kickCharacter: (name) ->
    @Chars.kickByName(name, @$scope.game).then (data) =>
      kickedChar = @Chars.findByName(name)
      if kickedChar
        index = @$scope.game.assignedCharacters.indexOf(kickedChar)
        @$scope.game.assignedCharacters.splice(index, 1)
        @$scope.successMessage = "Kicked #{name} from #{@$scope.game.name}"
    , (data) =>
      @$scope.errorMessage = 'Not assigned'


  subscribeToFaye: =>
    if @Faye?
      @Faye.subscribe "/combats", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'created' || msg.type == 'updated'
          @onCombatUpdated(msg.combat)
        if msg.type == 'deleted'
          @onCombatDeleted(msg.combat)

EditGameController.$inject = ["$scope", "$routeParams", "Game", "Combats", "Combat", "$injector", "$modal", "Faye", "$location", "Chars"]

angular.module("dndApp").controller("EditGameController", EditGameController)