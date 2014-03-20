window.Races ||= {}
class window.Races.Human extends Races.BaseRace
  selectedFor: (char) ->
    super(char)
    char.stat_increment_points || = 0
    char.stat_increment_points += 2
    char.speed = 6

  deselectedFor: (char) ->
    if char?
      super(char)
      char.stat_increment_points || = 0
      char.stat_increment_points += 2
      char.speed = undefined
