window.Races ||= {}
class window.Races.Dragonborn
  selectedFor: (char) ->
    char.cha += 2
    char.str += 2

  deselectedFor: (char) ->
    char.cha -= 2
    char.str -= 2
