window.Races ||= {}
class window.Races.Human extends Races.BaseRace
  selectedFor: (char) ->
    super(char)
    char.p.speed = 6

  deselectedFor: (char) ->
    if char?
      super(char)
      char.p.speed = undefined
