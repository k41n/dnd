#= require './base_attack'
#RU: Удар Стальной Змеи

window.Skills ||= {}
class window.Skills.SteelSnakeStrike extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  toHitBonus: (char) ->
#    char ||= @char
#    super(char)
    40

  damageRollCount: (char) ->
    char ||= @char
    char.weapon.damage_count * 2

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
      new CombatScroll("Slowed", '#ffff00', target.location).act()
    , 1000
    new Affects.Slowed().applyTo(@target, {by: @applicator, duration: 3})
    new Affects.Immobilized().applyTo(@target, {by: @applicator, duration: 1})
