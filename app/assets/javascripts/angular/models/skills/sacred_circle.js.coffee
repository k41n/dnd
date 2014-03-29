#= require ../affects/sacred_circle_buff

window.Skills ||= {}
class window.Skills.SacredCircle extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  toHitBonus: (char) ->
    char ||= @char
    super(char)

  damageRollCount: (char) ->
    2

  damageRollDice: (char) ->
    6

  damageBonus: (char) ->
    char ||= @char
    char.mod('cha')

  highlightTargets: (grid, applicator) ->
    grid.get(applicator.location).attackable = true

  beforeHit: ->
    new Affects.SacredCircleBuff().applyTo(@applicator, {by: @applicator})
