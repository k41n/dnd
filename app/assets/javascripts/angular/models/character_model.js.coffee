class window.CharacterModel
  constructor: (data) ->
    for key,val of data
      @[key] = val

  maxHP: ->
    return '-' unless @character_class?
    @calculateHP(@)

  getAC: ->
    armor_bonus = if @armor? then @armor.ac_bonus else 0 
    shield_bonus = if @shield? then @shield.ac_bonus else 0 
    if !@armor? or @armor.armor_type == 'Light'
      return 10 + armor_bonus + shield_bonus + Math.max(@mod('int'), @mod('dex')) + Math.floor(@level / 2)
    else
      return 10 + armor_bonus + shield_bonus + Math.floor(@level / 2)

  getStamina: ->
    bonus = if @staminaBonus? then @staminaBonus else 0
    return 10 + bonus + Math.max(@mod('str'), @mod('con')) + Math.floor(@level / 2)

  getReaction: ->
    bonus = if @reactionBonus? then @reactionBonus else 0
    return 10 + bonus + Math.max(@mod('dex'), @mod('int')) + Math.floor(@level / 2)

  getWill: ->
    bonus = if @willBonus then @willBonus else 0
    return 10 + bonus + Math.max(@mod('wis'), @mod('cha')) + Math.floor(@level / 2)

  mod: (attr) ->
    Math.floor( @[attr] - 10 )

  getHealsCount: ->
    return '-' unless @character_class?
    @character_class.healsCount(@)

  getInitiative: ->
    Math.floor( @level / 2 ) + @mod('dex')

  getWeaponDamage: ->
    return '-' unless @weapon
    "#{@weapon.damage_count}d#{@weapon.damage_dice}"

  getMasteryIn: (ability) ->
    train_bonus = if @abilityTrainings? && @abilityTrainings[ability.name]? && @abilityTrainings[ability.name] then 5 else 0
    Math.floor(@level / 2) + @mod(ability.dependent_on_stat) + train_bonus

  getTrainingsCount: ->
    trained_abilities = 0
    for k,v of @abilityTrainings
      trained_abilities += 1 if v
    @trainings_count - trained_abilities

  canTrain: (ability) ->
    @getTrainingsCount() > 0 && @abilityTrainings[ability.name] != true

  train: (ability) ->
    if @canTrain(ability)
      @abilityTrainings[ability.name] = true