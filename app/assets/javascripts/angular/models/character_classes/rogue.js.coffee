window.CharacterClasses ||= {}
class window.CharacterClasses.Rogue extends CharacterClasses.BaseCharacterClass
  forcedTrainings: ->
    ['Воровство', 'Скрытность']

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
      ( char.p.level - 1 ) * 5 + 12 + char.getStat('con')

  onDeselected: (char) ->
    char.reactionBonus -= 2

  healsCount: (char) ->
    6 + char.mod('con')

  reactionBonus: ->
    2

  