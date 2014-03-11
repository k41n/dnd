class window.ShowCombatController
  constructor: (@$scope, @$routeParams, @Zoo, @Combat, @Faye) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @fetchCombat()

  selectCell: (cell) ->
    if @$scope.selectedMonster
      unless cell.hasCreature()
        monster = new Creature(@$scope.selectedMonster)
        @$scope.grid.place(monster, cell.location.x, cell.location.y)
        @$scope.selectedMonster = null
        @saveCombat()
    else
      @$scope.zooActive = false
      @$scope.selectedCell = cell

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


ShowCombatController.$inject = ["$scope", "$routeParams", "Zoo", "Combat", "Faye"]

angular.module("dndApp").controller("EditCombatController", EditCombatController)