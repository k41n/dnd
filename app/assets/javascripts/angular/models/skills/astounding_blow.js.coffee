#= require './base_attack'

window.Skills ||= {}
class window.Skills.AstoundingBlow extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  toHitBonus: (char) ->
    char ||= @char
    super(char)

  damageRollCount: (char) ->
    char ||= @char
    char.weapon.damage_count

  damageRollDice: (char) ->
    char ||= @char
    char.weapon.damage_dice

  damageBonus: (char) ->
    char ||= @char
    char.mod('dex') + char.damageBonus()

  pickable: (char) ->
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки')

  beforeHit: ->
    new Affects.Dazed().applyTo(@target, {by: @applicator, duration: 2})
