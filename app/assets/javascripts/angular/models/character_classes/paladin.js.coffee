window.CharacterClasses ||= {}
class window.CharacterClasses.Paladin
  onSelected: (char) ->
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.staminaBonus += 1    
    char.reactionBonus += 1
    char.willBonus += 1
    char.calculateHP = ->
      ( @level - 1 ) * 6 + 15 + @con

  onDeselected: (char) ->
    char.staminaBonus ||= 0
    char.reactionBonus ||= 0
    char.willBonus ||= 0
    char.staminaBonus -= 1    
    char.reactionBonus -= 1
    char.willBonus -= 1


  healsCount: (char) ->
    10 + char.mod('con')

  