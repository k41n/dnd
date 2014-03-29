#= require ../affects/protective_shield_buff

window.Skills ||= {}
class window.Skills.ProtectiveShield extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  checkHit: ->
    true

  damageRollCount: ->
    0

  damageRollDice: ->
    0

  damageBonus: ->
    0

  beforeHit: ->
    new Affects.ProtectiveShieldBuff().applyTo(@target, {by: @applicator})
    @applicator.removeSkill @
