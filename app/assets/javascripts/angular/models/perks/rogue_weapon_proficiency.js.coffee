#= require './base_perk'

window.Perks ||= {}
class window.Perks.RogueWeaponProficiency extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.character_class && character.character_class.name == 'Плут'

  autoPickable: ->
    true

  toHitBonus: (character) ->
    if character && character.weapon? && character.weapon.title == 'Кинжал'
      1
    else 
      0