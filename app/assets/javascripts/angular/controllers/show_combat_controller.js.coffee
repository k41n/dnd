class window.ShowCombatController
  constructor: (@$scope, @$routeParams, @Zoo, @Combat, @Faye) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @fetchCombat()

  selectCell: (cell) ->
    if cell.moveable and @$scope.selectedCreature
      @moveToCell(@$scope.selectedCreature, cell)
    @$scope.selectedCell = cell
    @$scope.selectedCreature = cell.creature if cell.hasCreature()
    @saveCombat()

  isCellSelected: ->
    @$scope.selectedCell?

  deleteMonster: (monster) ->
    @$scope.grid.deleteMonster(monster)

  setMoveability: (val) ->
    @$scope.selectedCell.moveability = val
    @saveCombat()

  activateZooPanel: ->
    @$scope.selectedCell = null
    @$scope.zooActive = true

  selectMonster: (monster) ->
    @$scope.selectedMonster = monster

  fetchCombat: ->
    @$scope.combat = @Combat.get { id: @$routeParams.id }, (data) =>
      console.log 'Loading from JSON', data
      @$scope.combat.json = JSON.parse(data.json)
      console.log "@$scope.combat.json", @$scope.combat.json
      @$scope.grid.loadFromJSON(@$scope.combat.json) if @$scope.combat.json?

  saveCombat: ->
    @$scope.combat.json = @$scope.grid.saveToJSON()
    params =
      json: JSON.stringify(@$scope.combat.json)
    @Combat.update { id: @$scope.combat.id }, { combat: params }

  moveToCell: (creature, cell) ->
    @$scope.grid.move(creature, cell.location.x, cell.location.y)


  markMoveableCellsForCreature: (creature) =>
    @$scope.grid.markMoveableCellsForCreature(creature)


ShowCombatController.$inject = ["$scope", "$routeParams", "Zoo", "Combat", "Faye"]

angular.module("dndApp").controller("ShowCombatController", ShowCombatController)