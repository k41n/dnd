window.CharacterClasses ||= {}
class window.CharacterClasses.Paladin extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 1    
    char.reactionBonus += 1
    char.willBonus += 1

    char.abilityTrainings['Религия'] = true
    char.forcedTrainings = ['Религия']
    char.trainings_count = 4

    char.calculateHP = ->
      ( @p.level - 1 ) * 6 + 15 + @p.con

  onDeselected: (char) ->
    char.staminaBonus -= 1    
    char.reactionBonus -= 1
    char.willBonus -= 1

  healsCount: (char) ->
    10 + char.mod('con')

  