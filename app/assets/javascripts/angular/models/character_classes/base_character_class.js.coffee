window.CharacterClasses ||= {}
class window.CharacterClasses.BaseCharacterClass
  constructor: (factory_params) ->
    if factory_params
      for k,v of factory_params
        @[k] = v
  onSelected: (char) ->
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.abilityTrainings ||= {}
