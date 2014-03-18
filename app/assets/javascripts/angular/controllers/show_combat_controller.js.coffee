class window.ShowCombatController
  constructor: (@$scope, @$routeParams, @Zoo, @Combat, @Faye, @SkillLibrary, @$timeout, @CreaturesBand) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @fetchCombat()
    @subscribeToFaye()

  selectCell: (cell) ->
    if @canMoveToCell(cell)
      @moveToCell(@$scope.selectedCreature, cell)
      @saveCombat()
    if cell.attackable
      @$scope.selectedSkill.apply @$scope.selectedCell.creature, cell.creature
      @$scope.selectedSkill = undefined
      @$scope.grid.resetAttackHighlight()
      @saveCombat()
    @$scope.selectedCell = cell
    @$scope.selectedCreature = cell.creature if cell.hasCreature()

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
    @$timeout =>
      @$scope.combat = @Combat.get { id: @$routeParams.id }, (data) =>
        @loadFromData(data)

  loadFromData: (data) ->
    @$scope.combat.json = JSON.parse(data.json)
    @$scope.grid.loadFromJSON(@$scope.combat.json, @SkillLibrary, @Zoo) if @$scope.combat.json?
    @$scope.background_url = data.background_url if data.background_url?
    @$scope.creaturesBand = @CreaturesBand
    @$scope.creaturesBand.loadCreatures @$scope.grid.creatures

  saveCombat: ->
    @$scope.combat.json = @$scope.grid.saveToJSON()
    params =
      json: JSON.stringify(@$scope.combat.json)
    @Combat.update { id: @$scope.combat.id }, { combat: params }

  startUsingSkill: (skill) ->
    @$scope.selectedSkill = skill
    @$scope.selectedSkill.highlightTargets(@$scope.grid, @$scope.selectedCreature)


  moveToCell: (creature, cell) ->
    @$scope.grid.move(creature, cell.location)


  markMoveableCellsForCreature: (creature) =>
    @$scope.grid.markMoveableCellsForCreature(creature)

  canMoveToCell: (cell) ->
    if cell.moveable and @$scope.selectedCreature
      if cell.moveability == 3 or (cell.hasCreature())
        @$scope.selectedCreature = null
        @$scope.selectedCell = null
        @$scope.grid.unmarkMoveableCellsForCreature()
        return false
      return true

  subscribeToFaye: ->
    if @Faye?
      @Faye.subscribe "/combats", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'updated'
          @loadFromData(msg.combat)

ShowCombatController.$inject = ["$scope", "$routeParams", "Zoo", "Combat", "Faye", "SkillLibrary", "$timeout", "CreaturesBand"]

angular.module("dndApp").controller("ShowCombatController", ShowCombatController)