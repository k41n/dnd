window.Races ||= {}
class window.Races.Dwarf
  selectedFor: (char) ->
    char.con += 2

  deselectedFor: (char) ->
    char.con -= 2
