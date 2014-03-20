window.Races ||= {}
class window.Races.Dwarf extends Races.BaseRace
  selectedFor: (char) ->
    super(char)
    char.statBonuses.con += 2
    char.speed = 5

  deselectedFor: (char) ->
    if char?
      super(char)
      char.statBonuses.con -= 2
      char.speed = undefined
