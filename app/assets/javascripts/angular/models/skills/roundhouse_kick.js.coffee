#= require './../roll'

window.Skills ||= {}
class window.Skills.RoundhouseKick
  constructor: (factory_params) ->
    console.log "RoundhouseKick constructor", factory_params
    if factory_params
      @title = factory_params.title
      @avatar_url = factory_params.avatar_url
      @js_class = factory_params.js_class
      @attack_char_from = factory_params.attack_char_from
      @attack_char_to = factory_params.attack_char_to
      @damage_dice = factory_params.damage_dice
      @damage_count = factory_params.damage_count
      @damage_bonus = factory_params.damage_bonus
      @id = factory_params.id

  highlightTargets: (grid, applicator) ->
    for creature in grid.creaturesInRadius(applicator.location, 2)
      cell = grid.get(creature.location.x, creature.location.y)
      cell.attackable = true unless creature == applicator

  apply: (applicator, target) ->
    console.log "#{applicator.name} roundhouse kicked #{target.name}"

    # Rolling on hit
    to_hit = Roll.do(20, 1)
    console.log 'to_hit = ', to_hit
    to_hit_bonus = applicator[@attack_char_from]
    console.log 'to_hit_bonus = ', to_hit_bonus
    to_hit_penalty = target[@attack_char_to]
    console.log 'to_hit_penalty = ', to_hit_penalty
    if to_hit + to_hit_bonus > to_hit_penalty
      console.log 'Hit!'
      # Gotcha!
      # If any handler returns false, interrupt
      result = applicator.trigger 'hit',
        target: target

      return unless result

      result = target.trigger 'was_hit',
        enemy: applicator

      return unless result

      # Roll on damage

      damage_done = Roll.do(@damage_count, @damage_dice, @damage_bonus)

      applicator.trigger 'dealed_damage',
        target: target
        damage: damage_done

      target.trigger 'received_damage',
        enemy: applicator
        damage: damage_done
    else
      result = applicator.trigger 'missed',
        target: target

      return unless result

      result = target.trigger 'was_missed',
        enemy: applicator

      return unless result
