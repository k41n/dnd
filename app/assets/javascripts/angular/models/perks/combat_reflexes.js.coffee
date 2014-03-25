#= require './base_perk'

window.Perks ||= {}
class window.Perks.CombatReflexes extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.getStat('dex') >= 13
