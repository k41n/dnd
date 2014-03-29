#= require ./protecting_shield

window.Skills ||= {}
class window.Skills.ProtectingStrike extends Skills.BaseAttack
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
    char.mod('cha')

  beforeHit: ->
    @applicator.addSkillByJsClass('Skills.ProtectingShield')