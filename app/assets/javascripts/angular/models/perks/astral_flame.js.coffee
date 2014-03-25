#= require './base_perk'

window.Perks ||= {}
class window.Perks.AstralFlame extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.getStat('dex') >= 13 && character.getStat('cha') >= 13
