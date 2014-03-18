class window.CharactersController
  constructor: (@$scope, @Character, @$injector, @$modal, @$fileUploader, @Faye, @Racing) ->
    @fetchCharacters()
    @$scope.c = @
    @initFileUploader()
    @subscribeToFaye()

  fetchCharacters: ->
    @$scope.characters = {}
    characters = @Character.query {}, =>
      for character in characters
        @$scope.characters[character.id] = character

  createCharacter: (params)->
    new @Character(params).$save()

  showNewCharacterDialog: ->
    modalInstance = @$modal.open
      templateUrl: '/new_character_dialog.html'
      controller: 'NewCharacterDialogController'
    modalInstance.result.then (requisites) =>
      @createCharacter(requisites)

  editCharacter: (char) ->
    console.log "editCharacter", char
    @$scope.editedCharacter = char
    @$scope.uploader.url = "/api/characters/#{char.id}/avatar"
    @$scope.$watch 'editedCharacter.race', (newVal, oldVal) =>
      if newVal?
        console.log "Changed race to", newVal 
        race = @Racing.create(newVal)
        if race?
          race.selectedFor(@$scope.editedCharacter)
      if oldVal?
        console.log "Changed race from", oldVal 
        race = @Racing.create(oldVal)
        if race?
          race.deselectedFor(@$scope.editedCharacter)


  saveCharacter: ->
    new @Character(@$scope.editedCharacter).$update()
    @$scope.editedCharacter = null

  deleteCharacter: ->
    new @Character(@$scope.editedCharacter).$delete()
    @$scope.editedCharacter = null

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
            @$scope.editedCharacter.avatar_url = response.url
    catch e
      console.log e

  onCharacterUpdated: (data) =>
    @$scope.characters[data.id] = data
    unless @$scope.characters[data.id].avatar_url?
      @$scope.characters[data.id].avatar_url = '/unknown-character.png'

  onCharacterDeleted: (data) =>
    delete @$scope.characters[data.id]

  canIncrease: (attr, editedCharacter) ->
    return false unless editedCharacter?
    @priceOfIncrementFrom(editedCharacter[attr]) <= editedCharacter.stat_points

  canDecrease: (attr, editedCharacter) ->
    editedCharacter? && editedCharacter[attr] > 8

  priceOfIncrementFrom: (previousValue) ->
    return 1 if previousValue == 8
    return 1 if previousValue == 9
    return 1 if previousValue == 10
    return 1 if previousValue == 11
    return 1 if previousValue == 12
    return 2 if previousValue == 13
    return 2 if previousValue == 14
    return 2 if previousValue == 15
    return 3 if previousValue == 16

  increase: (attr, editedCharacter) ->
    previousValue = editedCharacter[attr]
    price = @priceOfIncrementFrom(previousValue)
    editedCharacter[attr] += 1
    editedCharacter.stat_points -= price

  decrease: (attr, editedCharacter) ->
    previousValue = editedCharacter[attr]
    price = @priceOfIncrementFrom(previousValue - 1)
    editedCharacter[attr] -= 1
    editedCharacter.stat_points += price

  subscribeToFaye: =>
    if @Faye?
      @Faye.subscribe "/characters", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'created' || msg.type == 'updated'
          @onCharacterUpdated(msg.character)
        if msg.type == 'deleted'
          @onCharacterDeleted(msg.character)


CharactersController.$inject = ["$scope", "Character", "$injector", "$modal", "$fileUploader", "Faye", "Racing"]

angular.module("dndApp").controller("CharactersController", CharactersController)