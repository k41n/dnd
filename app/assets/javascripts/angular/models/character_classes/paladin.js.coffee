window.CharacterClasses ||= {}
class window.CharacterClasses.Paladin extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 1    
    char.reactionBonus += 1
    char.willBonus += 1

    char.abilityTrainings['Религия'] = true
    char.forcedTrainings = ['Религия']

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
    ( char.p.level - 1 ) * 6 + 15 + char.getStat('con')

  onDeselected: (char) ->
    char.staminaBonus -= 1    
    char.reactionBonus -= 1
    char.willBonus -= 1

  healsCount: (char) ->
    10 + char.mod('con')

  