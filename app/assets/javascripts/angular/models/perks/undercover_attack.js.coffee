#= require './base_perk'

window.Perks ||= {}
class window.Perks.UndercoverAttack extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.character_class && character.character_class.name == 'Плут'

  autoPickable: ->
    true

  getDamageBonus: (target) ->
    if @character && @character.weapon? && @character.weapon.name == 'Кинжал' && @character.hasCombatSuperiorityOver(target)
      return [2,6]
    else 
      0