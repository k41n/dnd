window.CharacterClasses ||= {}
class window.CharacterClasses.Warlord extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 1
    char.willBonus += 1

    char.trainings_count ||= 4

    char.calculateHP = ->
      ( @level - 1 ) * 5 + 12 + @con

  onDeselected: (char) ->
    super(char)
    char.staminaBonus -= 1
    char.willBonus -= 1

  healsCount: (char) ->
    7 + char.mod('con')

  