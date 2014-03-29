#= require './../roll'

window.Skills ||= {}
class window.Skills.BaseAttack
  constructor: (factory_params) ->
    if factory_params
      for k,v of factory_params
        @[k] = v

  assignTo: (char) ->
    @char = char

  # Could and might be redefined in inherited objects
  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)

  highlightInRadius: (grid, applicator, radius) ->
    for creature in grid.creaturesInRadius(applicator.location, radius)
      cell = grid.get(creature.location)
      cell.attackable = true unless creature == applicator

  toHitVersus: ->
    @target.i[@attack_char_to]

  toHit: ->
    # Rolling on hit
    @to_hit = Roll.do(1, 20)
    @to_hit_bonus = @toHitBonus()
    @to_hit_penalty = @toHitVersus()

  toHitBonus: (char) ->
    char ||= @char
    char.halfLevel() + char.mod(@attack_char_from) + char.toHitBonus()

  damageText: (char) ->
    char ||= @char
    if char? 
      "#{@damageRollCount(char)}d#{@damageRollDice(char)}+#{@damageBonus(char)}"
    else
      " - "

  checkHit: ->
    @toHit()
    console.log "Rolled #{@to_hit + @to_hit_bonus} versus #{@to_hit_penalty}"
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

    @damage_done = @countDamageDone()

    @applicator.trigger 'dealed_damage',
      target: @target
      damage: @damage_done

    @target.trigger 'received_damage',
      enemy: @applicator
      damage: @damage_done

    @afterHit()

  afterHit: ->
    new CombatScroll("-#{@damage_done}", '#ff0000', @target.location).act()


  beforeHit: ->
    1

  pullMissTriggers: ->
    result = @applicator.trigger 'missed',
      target: @target

    return unless result

    result = @target.trigger 'was_missed',
      enemy: @applicator

    return unless result

  damageRollCount: (char) ->
    char.damage_count

  damageRollDice: (char)->
    char.damage_dice

  damageBonus: ->
    char.damageBonus

  countDamageDone: ->
    damage_done = Roll.do(@damageRollCount(), @damageRollDice(), @damageBonus())

  pickable: (char) ->
    @available_for.indexOf(char.p.character_class_id) != -1 && 
      char.p.skill_ids.indexOf(@id) == -1 && 
      char.p.level >= @min_level &&
      char.skillPoints(@cooldown_type) > 0

  apply: (applicator, target) ->
    console.log "Applying from", applicator
    console.log "Applying to", target
    @applicator = applicator
    @target = target
    if @checkHit()
      @pullHitTriggers()
    else
      console.log 'Missed!'
      @pullMissTriggers()
