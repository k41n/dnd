window.CharacterClasses ||= {}
class window.CharacterClasses.Mage extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.willBonus += 2

    char.abilityTrainings['Магия'] = true
    char.forcedTrainings = ['Магия']

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
      ( char.p.level - 1 ) * 4 + 10 + char.getStat('con')

  onDeselected: (char) ->
    super(char)
    char.willBonus -= 2

  healsCount: (char) ->
    6 + char.mod('con')

  