class window.CharacterAbilities
  constructor: (CharacterAbility) ->
    @loading = CharacterAbility.query {}, (data) =>
      @character_abilities = {}      
      for character_ability in data
        @character_abilities[character_ability.id] = character_ability

  create: (id) ->
    character_ability = @character_abilities[id]
    if character_ability?
      if character_ability.js_class?
        return new (eval(character_ability.js_class))(character_ability)
      else
        return new Abilities.BaseAbility(character_ability)

  findByName: (name) ->
    for id, a of @character_abilities
      return a if a.name == name
    return null


CharacterAbilities.$inject = ["CharacterAbility"]

angular.module("dndApp").service("CharacterAbilities", CharacterAbilities)