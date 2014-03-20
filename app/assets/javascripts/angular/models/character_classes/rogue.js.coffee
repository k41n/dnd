window.CharacterClasses ||= {}
class window.CharacterClasses.Rogue extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    char.reactionBonus += 2

    char.abilityTrainings ||= {}
    char.abilityTrainings['Воровство'] = true
    char.abilityTrainings['Скрытность'] = true
    char.forcedTrainings = ['Воровство', 'Скрытность']
    char.trainings_count ||= 6

    char.calculateHP = ->
      ( @level - 1 ) * 5 + 12 + @con

  onDeselected: (char) ->
    char.reactionBonus -= 2

  healsCount: (char) ->
    6 + char.mod('con')

  