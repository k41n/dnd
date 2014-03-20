class window.CharactersController
  constructor: (@$scope, @Character, @$injector, @$modal, @$fileUploader, @Faye, @Racing, @CharacterClasses, @Armors, @Weapons, @CharacterAbilities) ->
    @fetchCharacters()
    @$scope.c = @
    @initFileUploader()
    @subscribeToFaye()

  fetchCharacters: ->
    @$scope.characters = {}
    characters = @Character.query {}, =>
      for character in characters
        @$scope.characters[character.id] = character
        character.abilityTrainings = {}
        for a in character.character_ability_ids
          ability = @CharacterAbilities.character_abilities[a]
          character.abilityTrainings[ability.name] = true


  createCharacter: (params)->
    new @Character(params).$save()

  showNewCharacterDialog: ->
    modalInstance = @$modal.open
      templateUrl: '/new_character_dialog.html'
      controller: 'NewCharacterDialogController'
    modalInstance.result.then (requisites) =>
      @createCharacter(requisites)

  editCharacter: (char) ->
    @$scope.editedCharacter = new CharacterModel(char)
    @$scope.uploader.url = "/api/characters/#{char.id}/avatar"
    @$scope.$watch 'editedCharacter.race_id', (newVal, oldVal) =>
      if newVal? && @$scope.editedCharacter?
        race = @Racing.create(newVal)
        if race?
          if @$scope.editedCharacter.race? && @$scope.editedCharacter.race.id != race.id
            @$scope.editedCharacter.race.deselectedFor(@$scope.editedCharacter) 
          race.selectedFor(@$scope.editedCharacter)
          @$scope.editedCharacter.race = race

    @$scope.$watch 'editedCharacter.character_class_id', (newVal, oldVal) =>
      if newVal?
        character_class = @CharacterClasses.create(newVal)
        if character_class?
          if @$scope.editedCharacter.character_class? && @$scope.editedCharacter.character_class.id != character_class.id
            @$scope.editedCharacter.character_class.onDeselected(@$scope.editedCharacter)
          @$scope.editedCharacter.character_class = character_class
          character_class.onSelected(@$scope.editedCharacter)


    @$scope.$watch 'editedCharacter.armor_id', (newVal, oldVal) =>
      if newVal?
        armor = @Armors.create(newVal)
        if armor?
          @$scope.editedCharacter.armor = armor

    @$scope.$watch 'editedCharacter.shield_id', (newVal, oldVal) =>
      if newVal?
        shield = @Armors.create_shield(newVal)
        if shield?
          @$scope.editedCharacter.shield = shield

    @$scope.$watch 'editedCharacter.weapon_id', (newVal, oldVal) =>
      if newVal?
        weapon = @Weapons.create(newVal)
        if weapon?
          @$scope.editedCharacter.weapon = weapon

  saveCharacter: ->
    console.log "@$scope.editedCharacter.trainedAbilityIds(@CharacterAbilities) = ", @$scope.editedCharacter.trainedAbilityIds(@CharacterAbilities)
    @$scope.editedCharacter.character_ability_ids = @$scope.editedCharacter.trainedAbilityIds(@CharacterAbilities)
    nc = new @Character(@$scope.editedCharacter)
    nc.$update()
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
    character = @$scope.characters[data.id]
    character.abilityTrainings ||= {}
    for a in character.character_ability_ids
      ability = @CharacterAbilities.character_abilities[a]
      console.log "ability = ", ability

      character.abilityTrainings[ability.name] = true


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
    return 4 if previousValue == 17
    return 4 if previousValue == 18
    return 5 if previousValue == 19
    return 5 if previousValue == 20
    return 6 if previousValue == 21
    return 6 if previousValue == 22

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


CharactersController.$inject = ["$scope", "Character", "$injector", "$modal", "$fileUploader", "Faye", "Racing", "CharacterClasses", "Armors", "Weapons", "CharacterAbilities"]

angular.module("dndApp").controller("CharactersController", CharactersController)