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
    console.log "Editing character", char
    @$scope.editedCharacter = char
    @$scope.uploader.url = "/api/characters/#{char.id}/avatar"

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