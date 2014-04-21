#= require './base_attack'
#RU: Ответный удар

window.Skills ||= {}
class window.Skills.Counterstrike extends Skills.BaseAttack
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
    char.mod('dex')

  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)

  afterHit: ->
    new Affects.CounterstrikeDebuff().applyTo(@target, {by: @applicator})

  pickable: (char) ->
    super(char) && char.weapon? && char.weapon.weapon_group_name == 'Легкие клинки'
