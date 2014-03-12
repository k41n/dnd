class window.EditCombatController
  constructor: (@$scope, @$routeParams, @Combat, @Zoo, @Chars, @SkillLibrary) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @fetchCombat()
    @$scope.zooActive = true

  selectCell: (cell) ->
    if @$scope.selectedMonster
      unless cell.hasCreature()
        monster = new Creature(@$scope.selectedMonster)
        @$scope.grid.place(monster, cell.location.x, cell.location.y)
        @$scope.selectedMonster = null
        @saveCombat()
      return

    if @$scope.selectedChar
      unless cell.hasCreature()
        monster = new Creature(@$scope.selectedChar)
        @$scope.grid.place(monster, cell.location.x, cell.location.y)
        @$scope.selectedMonster = null
        @saveCombat()
      return

    @$scope.zooActive = false
    @$scope.charsetActive = false
    @$scope.selectedCell = cell

  setMoveability: (val) ->
    @$scope.selectedCell.moveability = val
    @saveCombat()

  isCellSelected: ->
    @$scope.selectedCell?

  selectMonster: (monster) ->
    @$scope.selectedMonster = monster

  selectCharacter: (char) ->
    @$scope.selectedChar = char

  activateZooPanel: ->
    @$scope.selectedCell = null
    @$scope.zooActive = true
    @$scope.charsetActive = false

  deleteMonster: (monster) ->
    @$scope.grid.deleteMonster(monster)
    @saveCombat()

  activateCharset: ->
    @$scope.selectedCell = null
    @$scope.zooActive = false
    @$scope.charsetActive = true

  fetchCombat: ->
    @$scope.combat = @Combat.get { id: @$routeParams.id }, (data) =>
      if data.json? && data.json.length > 0
        @$scope.combat.json = JSON.parse(data.json)
        @$scope.grid.loadFromJSON(@$scope.combat.json, @SkillLibrary) if @$scope.combat.json?

  saveCombat: ->
    @$scope.combat.json = @$scope.grid.saveToJSON()
    params = 
      json: JSON.stringify(@$scope.combat.json)
    @Combat.update { id: @$scope.combat.id }, { combat: params }


EditCombatController.$inject = ["$scope", "$routeParams", "Combat", "Zoo", "Chars", "SkillLibrary"]

angular.module("dndApp").controller("EditCombatController", EditCombatController)    