#= require './base_attack'

window.Skills ||= {}
class window.Skills.RoundhouseKick extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)

  apply: (applicator, target) ->
    @applicator = applicator
    @target = target
    if @checkHit()
      @pullHitTriggers()
    else
      @pullMissTriggers()
