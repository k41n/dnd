window.Races ||= {}
class window.Races.BaseRace
  constructor: (factory_params) ->
    if factory_params
      for k,v of factory_params
        @[k] = v

  statBonus: (stat) ->
    0

  getSpeed: ->
    0

  abilityBonus: (name) ->
    0