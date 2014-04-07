window.CharacterClasses ||= {}
class window.CharacterClasses.Warlock extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.willBonus += 1
    char.reactionBonus += 1

  classTrainingsCount: ->
    4

  calculateHP: (char) ->
      ( char.p.level - 1 ) * 5 + 12 + char.getStat('con')

  onDeselected: (char) ->
    super(char)
    char.willBonus -= 1
    char.reactionBonus -= 1

  healsCount: (char) ->
    6 + char.mod('con')

  