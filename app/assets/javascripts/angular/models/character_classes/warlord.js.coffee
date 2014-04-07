window.CharacterClasses ||= {}
class window.CharacterClasses.Warlord extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 1
    char.willBonus += 1

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
    ( char.p.level - 1 ) * 5 + 12 + char.getStat('con')

  onDeselected: (char) ->
    super(char)
    char.staminaBonus -= 1
    char.willBonus -= 1

  healsCount: (char) ->
    7 + char.mod('con')

  