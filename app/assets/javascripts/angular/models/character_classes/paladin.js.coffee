window.CharacterClasses ||= {}
class window.CharacterClasses.Paladin
  selectedFor: (char) ->
    char.stamina += 1
    char.reaction += 1
    char.will += 1

  deselectedFor: (char) ->
    char.stamina -= 1
    char.reaction -= 1
    char.will -= 1

  calculateHP: (char) ->
    ( char.level - 1 ) * 6 + 15 + char.con

  healsCount: (char) ->
    10 + char.mod('con')

  