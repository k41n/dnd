window.CharacterClasses ||= {}
class window.CharacterClasses.Mage extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.willBonus += 2

    char.abilityTrainings['Магия'] = true
    char.forcedTrainings = ['Магия']

    char.trainings_count ||= 4

    char.calculateHP = ->
      ( @level - 1 ) * 4 + 10 + @con

  onDeselected: (char) ->
    super(char)
    char.willBonus -= 2

  healsCount: (char) ->
    6 + char.mod('con')

  