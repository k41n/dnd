window.CharacterClasses ||= {}
class window.CharacterClasses.Warrior extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 2

    char.trainings_count ||= 3

    char.calculateHP = ->
      ( @level - 1 ) * 6 + 15 + @con

  onDeselected: (char) ->
    super(char)
    char.staminaBonus -= 2

  healsCount: (char) ->
    9 + char.mod('con')

  