class window.EditCombatController
  constructor: (@$scope, $routeParams, @Zoo) ->
    @$scope.c = @
    @$scope.grid = new Grid()
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

EditCombatController.$inject = ["$scope", "$routeParams", "Zoo"]

angular.module("dndApp").controller("EditCombatController", EditCombatController)    