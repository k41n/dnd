window.CharacterClasses ||= {}
class window.CharacterClasses.Priest extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.willBonus += 2

    char.abilityTrainings['Религия'] = true
    char.forcedTrainings = ['Религия']

    char.trainings_count ||= 4

    char.calculateHP = ->
      ( @level - 1 ) * 5 + 12 + @con

  onDeselected: (char) ->
    super(char)
    char.willBonus -= 2

  healsCount: (char) ->
    7 + char.mod('con')

  