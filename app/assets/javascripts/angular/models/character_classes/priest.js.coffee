window.CharacterClasses ||= {}
class window.CharacterClasses.Priest extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.willBonus += 2

    char.abilityTrainings['Религия'] = true
    char.forcedTrainings = ['Религия']

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
      ( char.p.level - 1 ) * 5 + 12 + char.getStat('con')

  onDeselected: (char) ->
    super(char)
    char.willBonus -= 2

  healsCount: (char) ->
    7 + char.mod('con')

  