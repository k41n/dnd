window.CharacterClasses ||= {}
class window.CharacterClasses.Rogue extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.reactionBonus += 2

    char.abilityTrainings ||= {}
    char.abilityTrainings['Воровство'] = true
    char.abilityTrainings['Скрытность'] = true
    char.forcedTrainings = ['Воровство', 'Скрытность']
    char.trainings_count ||= 6

    char.calculateHP = ->
      ( @level - 1 ) * 5 + 12 + @con

  onDeselected: (char) ->
    console.log "onDeselected"
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.reactionBonus -= 2
    char.abilityTrainings = {}
    char.trainings_count = undefined
    char.forcedTrainings = undefined

  healsCount: (char) ->
    6 + char.mod('con')

  