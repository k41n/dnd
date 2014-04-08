window.Races ||= {}
class window.Races.Halfling extends Races.BaseRace
  statBonus: (stat) ->
    if stat == 'cha' || stat == 'dex'
      2
    else 
      0

  getSpeed: ->
    6
