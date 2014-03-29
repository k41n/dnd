class window.Chars
  constructor: (@Character, @$injector, @$http, @CharacterAbilities, @Perks, @SkillLibrary) ->
    console.log "Chars service constructor"
    console.log "@SkillLibrary = ", @SkillLibrary    
    @loading = @Character.query {}, (data) =>
      @characters = {}
      for c in data
        @characters[c.id] = c

  create: (id) ->
    console.log "@SkillLibrary = ", @SkillLibrary    
    character = new CharacterModel(@characters[id], @SkillLibrary)
    character.data = @characters[id]
    character.abilityTrainings = {}
    for a in character.data.character_ability_ids
      ability = @CharacterAbilities.character_abilities[a]
      character.abilityTrainings[ability.name] = true
    character.perks = {}
    for perk_id in character.data.perk_ids
      perk = @Perks.perks[perk_id]
      character.perks[perk.id] = perk
    character.skills = {}
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

Chars.$inject = ["Character", "$injector", '$http', 'CharacterAbilities', 'Perks', 'SkillLibrary']

angular.module("dndApp").service("Chars", Chars)