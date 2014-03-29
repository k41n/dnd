#= require './base_attack'

window.Skills ||= {}
class window.Skills.AstralSpeech extends Skills.BaseAttack
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
