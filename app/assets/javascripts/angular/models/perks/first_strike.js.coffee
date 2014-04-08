#= require './base_perk'

window.Perks ||= {}
class window.Perks.FirstStrike extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.character_class && character.character_class.name == 'Плут'

  autoPickable: ->
    true

  hasCombatSuperiorityOver: (char) ->
    if char.hadTurnInCombat()
      false
    else 
      true