window.Races ||= {}
class window.Races.BaseRace
  selectedFor: (char) ->
    1
    char.statBonuses ||= {}

  deselectedFor: (char) ->
    if char?
      char.statBonuses ||= {}
