#= require './../roll'

window.Skills ||= {}
class window.Skills.BaseAttack
  constructor: (factory_params) ->
    if factory_params
      for k,v of factory_params
        console.log k,v
        @[k] = v

  highlightInRadius: (grid, applicator, radius) ->
    for creature in grid.creaturesInRadius(applicator.location, radius)
      cell = grid.get(creature.location)
      cell.attackable = true unless creature == applicator

  toHit: ->
    # Rolling on hit
    console.log @applicator
    @to_hit = Roll.do(20, 1)
    console.log 'to_hit = ', @to_hit
    @to_hit_bonus = @applicator.data[@attack_char_from]
    console.log 'to_hit_bonus = ', @to_hit_bonus
    @to_hit_penalty = @target.data[@attack_char_to]
    console.log 'to_hit_penalty = ', @to_hit_penalty

  checkHit: ->
    @toHit()
    @to_hit + @to_hit_bonus > @to_hit_penalty

  pullHitTriggers: ->
    @beforeHit()
    # Gotcha!
    # If any handler returns false, interrupt
    result = @applicator.trigger 'hit',
      target: @target

    return unless result

    result = @target.trigger 'was_hit',
      enemy: @applicator

    return unless result

    # Roll on damage

    damage_done = @countDamageDone()

    @applicator.trigger 'dealed_damage',
      target: @target
      damage: damage_done

    @target.trigger 'received_damage',
      enemy: @applicator
      damage: damage_done

    afterHit()

  afterHit: ->
    console.log 'after hit'

  beforeHit: ->
    1

  pullMissTriggers: ->
    result = @applicator.trigger 'missed',
      target: @target

    return unless result

    result = @target.trigger 'was_missed',
      enemy: @applicator

    return unless result

  countDamageDone: ->
    damage_done = Roll.do(@damage_count, @damage_dice, @damage_bonus)
