window.CharacterClasses ||= {}
class window.CharacterClasses.Rogue
  onSelected: (char) ->
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.reactionBonus += 2

    char.abilityTrainings = {}
    char.abilityTrainings['Воровство'] = true
    char.abilityTrainings['Скрытность'] = true
    char.trainings_count = 6

    char.calculateHP = ->
      ( @level - 1 ) * 5 + 12 + @con

  onDeselected: (char) ->
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.reactionBonus -= 2
    char.abilityTrainings = {}

  healsCount: (char) ->
    6 + char.mod('con')

  