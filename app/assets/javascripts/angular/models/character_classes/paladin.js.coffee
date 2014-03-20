window.CharacterClasses ||= {}
class window.CharacterClasses.Paladin extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 1    
    char.reactionBonus += 1
    char.willBonus += 1

    char.abilityTrainings ||= {}
    char.abilityTrainings['Религия'] = true
    char.forcedTrainings = ['Религия']
    char.trainings_count = 4

    char.calculateHP = ->
      ( @level - 1 ) * 6 + 15 + @con

  onDeselected: (char) ->
    console.log "onDeselected Paladin"    
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.staminaBonus -= 1    
    char.reactionBonus -= 1
    char.willBonus -= 1
    char.abilityTrainings = {}
    char.trainings_count = undefined
    char.forcedTrainings = undefined


  healsCount: (char) ->
    10 + char.mod('con')

  