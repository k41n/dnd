#= require './../roll'

window.Skills ||= {}
class window.Skills.GodDamage
  constructor: () ->
    console.log "GodDamage constructor"
    @name = 'God Hand'
#    if factory_params
#      @title = factory_params.title
#      @avatar_url = factory_params.avatar_url
#      @js_class = factory_params.js_class
#      @attack_char_from = factory_params.attack_char_from
#      @attack_char_to = factory_params.attack_char_to
#      @damage_dice = factory_params.damage_dice
#      @damage_count = factory_params.damage_count
#      @damage_bonus = factory_params.damage_bonus
#      @id = factory_params.id

  highlightTargets: (grid) ->
    for creature in grid.creatures
      cell = grid.get(creature.location)
      cell.attackable = true

  apply: (target) ->
    target.trigger 'was_hit',
     enemy:
      name: 'God'

    damage_done = 20

    target.trigger 'received_damage',
      damage: damage_done
      enemy:
        name: 'God'
