window.Races ||= {}
class window.Races.Human extends Races.BaseRace
  selectedFor: (char) ->
    super(char)
    char.p.stat_increment_points || = 0
    char.p.stat_increment_points += 2
    char.p.speed = 6

  deselectedFor: (char) ->
    if char?
      super(char)
      char.p.stat_increment_points || = 0
      char.p.stat_increment_points += 2
      char.p.speed = undefined
