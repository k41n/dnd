#= require './base_attack'

window.Skills ||= {}
class window.Skills.EasyTarget extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  toHitBonus: (char) ->
    char ||= @char
    super(char)

  damageRollCount: (char) ->
    char ||= @char
    char.weapon.damage_count * 2

  damageRollDice: (char) ->
    char ||= @char
    char.weapon.damage_dice

  damageBonus: (char) ->
    char ||= @char
    char.mod('dex') + char.damageBonus()

  pickable: (char) ->
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки' ||
        char.weapon.weapon_group_name == 'Арбалеты' ||
        char.weapon.weapon_group_name == 'Пращи' )

  beforeHit: ->
    new Affects.EasyTarget().applyTo(@target, {by: @applicator, duration: 2})
