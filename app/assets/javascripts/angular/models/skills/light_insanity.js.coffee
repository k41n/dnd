#= require ../affects/light_insanity_debuff

window.Skills ||= {}
class window.Skills.LightInsanity extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  toHitBonus: (char) ->
    char ||= @char
    super(char)

  damageRollCount: (char) ->
    3

  damageRollDice: (char) ->
    8

  damageBonus: (char) ->
    char ||= @char
    char.mod('cha')

  beforeHit: ->
    new Affects.LightInsanityDebuff().applyTo(@target, {by: @applicator})

  pullMissTriggers: ->
    console.log 'pullMissTriggers'
    result = @applicator.trigger 'missed',
      target: @target

    return unless result

    result = @target.trigger 'was_missed',
      enemy: @applicator

    return unless result

    @damage_done = Math.floor( @countDamageDone() / 2 )

    @applicator.trigger 'dealed_damage',
      target: @target
      damage: @damage_done

    @target.trigger 'received_damage',
      enemy: @applicator
      damage: @damage_done

    new Affects.LightInsanityDebuff().applyTo(@target, {by: @applicator, keepAc: true})