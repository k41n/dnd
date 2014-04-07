window.Races ||= {}
class window.Races.Dragonborn extends Races.BaseRace
  getSpeed: ->
    6

  statBonus: (stat) ->
    if stat == 'cha' || stat == 'str'
      2
    else 
      0

  abilityBonus: (name) ->
    if name == 'Запугивание' || name == 'История'
      2
    else
      0