class window.CharactersController
  constructor: (@$scope, @CharacterAPI, @CharacterModel, @$injector, @$modal, @$fileUploader, @Faye, @Racing, @CharacterClasses, @Armors, @Weapons, @CharacterAbilities, @Deities, @Perks, @SkillLibrary, @Chars) ->
    @$scope.c = @
    @initFileUploader()

  createCharacter: (params)->
    @Chars.createNew()

  showNewCharacterDialog: ->
    modalInstance = @$modal.open
      templateUrl: '/new_character_dialog.html'
      controller: 'NewCharacterDialogController'
    modalInstance.result.then (requisites) =>
      @createCharacter(requisites)

  editCharacter: (char) ->
    @$scope.editedCharacter = char
    @$scope.uploader.url = "/api/characters/#{char.p.id}/avatar"
    @$scope.$watch 'editedCharacter.p.race_id', (newVal, oldVal) =>
      if newVal? && @$scope.editedCharacter?
        race = @Racing.create(newVal)
        if race?
          if @$scope.editedCharacter.race? && @$scope.editedCharacter.race.id != newVal
            @$scope.editedCharacter.race.deselectedFor(@$scope.editedCharacter) 
          race.selectedFor(@$scope.editedCharacter)
          @$scope.editedCharacter.race = race

    @$scope.$watch 'editedCharacter.p.character_class_id', (newVal, oldVal) =>
      if newVal?
        character_class = @CharacterClasses.create(newVal)
        if character_class?
          if @$scope.editedCharacter.character_class? && @$scope.editedCharacter.character_class.id != character_class.id
            @$scope.editedCharacter.character_class.onDeselected(@$scope.editedCharacter)
          @$scope.editedCharacter.character_class = character_class
          character_class.onSelected(@$scope.editedCharacter)

    @$scope.$watch 'editedCharacter.p.deity_id', (newVal) =>
      if newVal?
        deity = @Deities.deities[newVal]
        if deity?
          @$scope.editedCharacter.deity = deity

    @$scope.$watch 'editedCharacter.p.armor_id', (newVal, oldVal) =>
      if newVal?
        armor = @Armors.create(newVal)
        if armor?
          @$scope.editedCharacter.armor = armor

    @$scope.$watch 'editedCharacter.p.shield_id', (newVal, oldVal) =>
      if newVal?
        shield = @Armors.create_shield(newVal)
        if shield?
          @$scope.editedCharacter.shield = shield

    @$scope.$watch 'editedCharacter.p.weapon_id', (newVal, oldVal) =>
      if newVal?
        weapon = @Weapons.create(newVal)
        if weapon?
          @$scope.editedCharacter.weapon = weapon

  saveCharacter: ->
    @$scope.editedCharacter.character_ability_ids = @$scope.editedCharacter.trainedAbilityIds(@CharacterAbilities)
    @$scope.editedCharacter.perk_ids = @$scope.editedCharacter.perkIds()
    @$scope.editedCharacter.skill_ids = @$scope.editedCharacter.skillIds()
    @$scope.editedCharacter.p.hp = @$scope.editedCharacter.maxHP()
    @$scope.editedCharacter.p.ac = @$scope.editedCharacter.getAC()
    nc = new @CharacterAPI(@$scope.editedCharacter.p)
    nc.$update()
    @$scope.editedCharacter = null

  deleteCharacter: ->
    new @CharacterAPI(@$scope.editedCharacter.p).$delete()
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
    @$scope.characters[data.id] = @CharacterModel.new(data)
    character = @$scope.characters[data.id]
    character.abilityTrainings ||= {}
    for a in character.character_ability_ids
      ability = @CharacterAbilities.character_abilities[a]
      character.abilityTrainings[ability.name] = true
    character.perks || = {}
    for perk_id in character.perk_ids
      perk = @Perks.perks[perk_id]
      character.perks[perk.id] = perk
    character.skills = {}
    for skill_id in character.skill_ids
      skill = @SkillLibrary.skills[skill_id]
      character.skills[skill.id] = skill


    unless @$scope.characters[data.id].avatar_url?
      @$scope.characters[data.id].avatar_url = '/unknown-character.png'

  onCharacterDeleted: (data) =>
    delete @$scope.characters[data.id]

CharactersController.$inject = ["$scope", "CharacterAPI", 'CharacterModel', "$injector", "$modal", "$fileUploader", "Faye", "Racing", "CharacterClasses", "Armors", "Weapons", "CharacterAbilities", "Deities", "Perks", "SkillLibrary", "Chars"]

angular.module("dndApp").controller("CharactersController", CharactersController)