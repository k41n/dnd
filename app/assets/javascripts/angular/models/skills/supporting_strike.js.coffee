#= require ../affects/supporting_strike_buff

window.Skills ||= {}
class window.Skills.SupportingStrike extends Skills.BaseAttack
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
    console.log 'beforeHit'
    new Affects.SupportingStrikeBuff().applyTo(@applicator, {by: @applicator})
