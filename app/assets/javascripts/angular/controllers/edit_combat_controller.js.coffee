class window.EditCombatController
  constructor: (@$scope, @$routeParams, @Zoo, @Combat) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @fetchCombat()
    @$scope.zooActive = true

  selectCell: (cell) ->
    @$scope.selectedCell = cell

  isCellSelected: ->
    @$scope.selectedCell?

  selectMonster: (monster) ->
    @$scope.selectedMonster = monster

  markMoveableCellsForCreature: (creature) =>
    @$scope.grid.markMoveableCellsForCreature(creature)

  fetchCombat: ->
    @$scope.combat = @Combat.get { id: @$routeParams.id }, (data) =>
      if data.json? && data.json.length > 0
        @$scope.combat.json = JSON.parse(data.json)
        @$scope.grid.loadFromJSON(@$scope.combat.json) if @$scope.combat.json?

  saveCombat: ->
    @$scope.combat.json = @$scope.grid.saveToJSON()
    params = 
      json: JSON.stringify(@$scope.combat.json)
    @Combat.update { id: @$scope.combat.id }, { combat: params }


EditCombatController.$inject = ["$scope", "$routeParams", "Zoo", "Combat"]

angular.module("dndApp").controller("EditCombatController", EditCombatController)    