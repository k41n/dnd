class window.CharacterClasses
  constructor: (CharacterClass) ->
    @loading = CharacterClass.query {}, (data) =>
      @character_classes = {}      
      for character_class in data
        @character_classes[character_class.id] = character_class

  create: (id) ->
    character_class = @character_classes[id]
    if character_class? && character_class.js_class? && eval(character_class.js_class)?
      return new (eval(character_class.js_class))(character_class)
    else
      return new CharacterClasses.BaseCharacterClass(character_class)

CharacterClasses.$inject = ["CharacterClass"]

angular.module("dndApp").service("CharacterClasses", CharacterClasses)