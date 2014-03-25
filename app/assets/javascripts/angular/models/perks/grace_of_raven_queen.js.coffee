#= require './base_perk'

window.Perks ||= {}
class window.Perks.GraceOfRavenQueen extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.deity? && character.deity.name == 'Королева Воронов'
