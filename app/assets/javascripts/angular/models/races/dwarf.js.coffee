window.Races ||= {}
class window.Races.Dwarf
  selectedFor: (char) ->
    char.statBonuses ||= {}
    char.statBonuses.con ||= 0
    char.statBonuses.con += 2

  deselectedFor: (char) ->
    if char?
      char.statBonuses ||= {}
      char.statBonuses.con ||= 0
      char.statBonuses.con -= 2
