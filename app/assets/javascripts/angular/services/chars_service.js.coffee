class window.Chars
  constructor: (@CharacterAPI, @CharacterModel, @Faye) ->
    @loading = @CharacterAPI.query {}, (data) =>
      console.log "Character api bring us", data
      @characters = {}
      for c in data
        @characters[c.id] = @CharacterModel.new(c)
    @listenFaye()

  create: (id) ->
    character = new CharacterModel(@characters[id], @SkillLibrary)
    character.data = @characters[id]
    character.abilityTrainings = {}
    if character.data.character_ability_ids?
      for a in character.data.character_ability_ids
        ability = @CharacterAbilities.character_abilities[a]
        character.abilityTrainings[ability.name] = true
    character.perks = {}
    if character.data.perk_ids?
      for perk_id in character.data.perk_ids
        perk = @Perks.perks[perk_id]
        character.perks[perk.id] = perk
    character.skills = {}
    if character.data.skill_ids?
      for skill_id in character.data.skill_ids
        skill = @SkillLibrary.skills[skill_id]
        character.skills[skill.id] = skill
    character

  inviteByName: (name, toGame) ->
    c = new @Character()
    c.$invite {gameId: toGame.id, name: name}

  uninviteByName: (name, toGame) ->
    c = new @Character()
    c.$uninvite {gameId: toGame.id, name: name}

  kickByName: (name, fromGame) ->
    c = new @Character()
    c.$kick {gameId: fromGame.id, name: name}

  findByName: (name) ->
    for id, char of @characters
      return char if char.name == name
    return null

  names: ->
    ret = []
    for id, char of @characters
      ret.push char.name
    ret

  listenFaye: ->
    if @Faye?
      @Faye.subscribe "/characters", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'created' || msg.type == 'updated'
          @onCharacterUpdated(msg.character)
        if msg.type == 'deleted'
          @onCharacterDeleted(msg.character)

  onCharacterUpdated: (data) =>
    char = @CharacterModel.new(data)
    @characters[data.id] = char

  createNew: ->
    new @CharacterAPI().$save()

Chars.$inject = ['CharacterAPI', 'CharacterModel', 'Faye']

angular.module("dndApp").service("Chars", Chars)