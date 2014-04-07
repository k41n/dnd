window.CharacterClasses ||= {}
class window.CharacterClasses.Ranger extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.staminaBonus += 1
    char.reactionBonus += 1

    char.abilityTrainings['Природа'] = true
    char.forcedTrainings = ['Природа']

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
      ( char.p.level - 1 ) * 5 + 12 + char.getStat('con')

  onDeselected: (char) ->
    super(char)
    char.staminaBonus -= 1
    char.reactionBonus -= 1

  healsCount: (char) ->
    6 + char.mod('con')

  