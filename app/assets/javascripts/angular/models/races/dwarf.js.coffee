window.Races ||= {}
class window.Races.Dwarf extends Races.BaseRace
  getSpeed: ->
    5

  statBonus: (stat) ->
    if stat == 'con'
      2
    else 
      0
