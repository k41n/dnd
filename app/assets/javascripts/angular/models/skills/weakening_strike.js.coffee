#= require ../affects/weakening_strike_debuff

window.Skills ||= {}
class window.Skills.WeakeningStrike extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  damage: (char) ->
    char.getWeaponDamage() + '+' + char.mod('cha')

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
    char.mod('cha')

  beforeHit: ->
    new Affects.WeakeningStrikeDebuff().applyTo(@target, {by: @applicator})
