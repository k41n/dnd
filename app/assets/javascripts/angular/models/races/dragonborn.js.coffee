window.Races ||= {}
class window.Races.Dragonborn
  selectedFor: (char) ->
    char.statBonuses ||= {}
    char.statBonuses.cha ||= 0
    char.statBonuses.cha += 2
    char.statBonuses.str ||= 0
    char.statBonuses.str += 2

  deselectedFor: (char) ->
    if char?
      char.statBonuses ||= {}
      char.statBonuses.cha ||= 0
      char.statBonuses.cha -= 2
      char.statBonuses.str ||= 0
      char.statBonuses.str -= 2
