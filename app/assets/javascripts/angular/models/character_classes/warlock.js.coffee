window.CharacterClasses ||= {}
class window.CharacterClasses.Warlock extends CharacterClasses.BaseCharacterClass
  onSelected: (char) ->
    super(char)
    char.willBonus += 1
    char.reactionBonus += 1

    char.trainings_count ||= 4

    char.calculateHP = ->
      ( @level - 1 ) * 5 + 12 + @con

  onDeselected: (char) ->
    super(char)
    char.willBonus -= 1
    char.reactionBonus -= 1

  healsCount: (char) ->
    6 + char.mod('con')

  