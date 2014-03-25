#= require './base_attack'
#RU: Косящий удар, воин, 1 уровень, неограниченный.

window.Skills ||= {}
class window.Skills.ReapingStrike extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  countDamageDone: ->
    Roll.do(@applicator.data.weapons[0].damage_count, @applicator.data.weapons[0].damage_dice, @applicator.data.str)

  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)

  apply: (applicator, target) ->
    @applicator = applicator
    @target = target
    if @checkHit()
      @pullHitTriggers()
    else
      @pullMissTriggers()
