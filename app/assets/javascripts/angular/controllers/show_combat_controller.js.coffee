class window.ShowCombatController
  constructor: (@$scope, @$routeParams, @Zoo, @Combat, @Faye, @SkillLibrary, @$timeout, @CreaturesBand, @current_user, @Chars, @Perks) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @$scope.currentUser = @current_user
    @Zoo.loading.$promise.then =>
      @Perks.loading.$promise.then =>
        @fetchCombat()
    @subscribeToFaye()

  selectCell: (cell) ->
    if @canMoveToCell(cell)
      @moveToCell(@$scope.selectedCreature, cell)
      @saveCombat()
    if cell.attackable
      if @$scope.selectedSkill.name == 'God Hand'
        @$scope.selectedSkill.apply cell.creature
      else
        @$scope.selectedSkill.apply @$scope.selectedCell.creature, cell.creature
      @$scope.selectedSkill = undefined
      @$scope.grid.resetAttackHighlight()
      @saveCombat()
    if @$scope.selectedSkill and not cell.attackable
      @$scope.selectedSkill = null
      @$scope.grid.resetAttackHighlight()
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
    @$scope.grid.loadFromJSON(@$scope.combat.json, @SkillLibrary, @Zoo, @Chars) if @$scope.combat.json?
    @$scope.background_url = data.background_url if data.background_url?
    @$scope.creaturesBand = @CreaturesBand
    @$scope.creaturesBand.loadCreatures @$scope.grid

  saveCombat: ->
    @$scope.combat.json = @$scope.grid.saveToJSON()
    console.log @$scope.combat.json
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

  endTurn: (creature) ->
    @$scope.creaturesBand.endTurn(creature)

  setCreatureRotatable: (creature) =>
    creature.rotatable = true

  rotateCreature: (creature, direction) =>
    @$scope.grid.rotate(creature, direction)
    creature.rotatable = false
    @saveCombat()

  turnOnGodDamageMode: ->
    @$scope.selectedSkill = new Skills.GodDamage()
    @$scope.selectedSkill.highlightTargets(@$scope.grid, @$scope.selectedCreature)
    console.log @$scope.selectedSkill


ShowCombatController.$inject = ["$scope", "$routeParams", "Zoo", "Combat", "Faye", "SkillLibrary", "$timeout", "CreaturesBand", "current_user", 'Chars', 'Perks']

angular.module("dndApp").controller("ShowCombatController", ShowCombatController)