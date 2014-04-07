window.CharacterClasses ||= {}
class window.CharacterClasses.Warrior extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 2

  classTrainingsCount: ->
    3

  calculateHP: (char) ->
    ( char.p.level - 1 ) * 6 + 15 + char.getStat('con')

  onDeselected: (char) ->
    super(char)
    char.staminaBonus -= 2

  healsCount: (char) ->
    9 + char.mod('con')

  