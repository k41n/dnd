class window.EditCombatController
  constructor: (@$scope, @$routeParams, @Zoo, @Combat) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @fetchCombat()
    @$scope.zooActive = true

  selectCell: (cell) ->
    if @$scope.selectedMonster
      monster = new Creature(@$scope.selectedMonster)
      @$scope.grid.place(monster, cell.location.x, cell.location.y)
      @$scope.selectedMonster = null
    else
      @$scope.zooActive = false
      @$scope.selectedCell = cell

  setMoveability: (val) ->
    @$scope.selectedCell.moveability = val

  activateZooPanel: ->
    @$scope.selectedCell = null
    @$scope.zooActive = true

  selectMonster: (monster) ->
    @$scope.selectedMonster = monster

  fetchCombat: ->
    @$scope.combat = @Combat.get { id: @$routeParams.id }, =>
      @$scope.grid.loadFromJSON(@$scope.combat.json) if @$scope.combat.json?

EditCombatController.$inject = ["$scope", "$routeParams", "Zoo", "Combat"]

angular.module("dndApp").controller("EditCombatController", EditCombatController)    