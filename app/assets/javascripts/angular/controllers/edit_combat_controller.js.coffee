class window.EditCombatController
  constructor: (@$scope, @$routeParams, @Combat, @Zoo, @Chars, @SkillLibrary, @$fileUploader) ->
    @$scope.c = @
    @$scope.grid = new Grid()
    @initFileUploader()
    Zoo.loading.$promise.then =>
      @fetchCombat()
    @$scope.zooActive = true

  initFileUploader: ->
    try
      if @$fileUploader
        csrf_token = $('meta[name=csrf-token]').attr('content')
        @$scope.uploader = @$fileUploader.create
          scope: @$scope
          autoUpload: true
          removeAfterUpload: true
          headers:
            'X-CSRF-TOKEN' : csrf_token
        if @$scope.uploader?
          @$scope.uploader.bind 'success', (event, xhr, item, response) =>
            @$scope.background_url = response.url
    catch e
      console.log e


  selectCell: (cell) ->
    if @$scope.selectedMonster
      unless cell.hasCreature()
        monster = new Creature(@$scope.selectedMonster.data)
        @$scope.grid.place(monster, cell.location)
        @$scope.selectedMonster = null
        @saveCombat()
      return

    if @$scope.selectedChar
      unless cell.hasCreature()
        monster = new Creature(@$scope.selectedChar)
        @$scope.grid.place(monster, cell.location)
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

  activateSettings: ->
    @$scope.selectedCell = null
    @$scope.zooActive = false
    @$scope.charsetActive = false

    @$scope.settingsActive = true

  fetchCombat: ->
    @$scope.uploader.url = "/api/combats/#{@$routeParams.id}/background" if @$scope.uploader?
    @$scope.combat = @Combat.get { id: @$routeParams.id }, (data) =>
      @$scope.background_url = data.background_url
      if data.json? && data.json.length > 0
        @$scope.combat.json = JSON.parse(data.json)
        @$scope.grid.loadFromJSON(@$scope.combat.json, @SkillLibrary, @Zoo) if @$scope.combat.json?

  saveCombat: ->
    @$scope.combat.json = @$scope.grid.saveToJSON()
    params = 
      json: JSON.stringify(@$scope.combat.json)
    @Combat.update { id: @$scope.combat.id }, { combat: params }


EditCombatController.$inject = ["$scope", "$routeParams", "Combat", "Zoo", "Chars", "SkillLibrary", "$fileUploader"]

angular.module("dndApp").controller("EditCombatController", EditCombatController)    