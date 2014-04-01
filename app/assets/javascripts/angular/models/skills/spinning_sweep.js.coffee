#= require './base_attack'
#RU: Косящий удар, воин, 1 уровень, неограниченный.

window.Skills ||= {}
class window.Skills.SpinningSweep extends Skills.BaseAttack
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
    char.mod('str')

  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)

  apply: (applicator, target) ->
    @applicator = applicator
    @target = target
    if @checkHit()
      @pullHitTriggers()
    else
      @pullMissTriggers()

  afterHit: ->
    super
    target = @target
    setTimeout ->
      new CombatScroll("KnockBack", '#ffff00', target.location).act()
    , 1000
    new Affects.Knockback().applyTo(@target, {by: @applicator})
