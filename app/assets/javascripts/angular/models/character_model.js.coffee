class window.CharacterModel
  constructor: (data) ->
    for key,val of data
      @[key] = val

  maxHP: ->
    return '-' unless @character_class?
    @character_class.calculateHP(@)

  getStamina: ->
    @stamina

  getReaction: ->
    @reaction

  getWill: ->
    @will

  getAC: ->
    armor_bonus = if @armor? then @armor.ac_bonus else 0 
    shield_bonus = if @shield? then @shield.ac_bonus else 0 
    if !@armor? or @armor.armor_type == 'Light'
      return 10 + armor_bonus + shield_bonus + Math.max(@mod('int'), @mod('dex')) + Math.floor(@level / 2)
    else
      return 10 + armor_bonus + shield_bonus + Math.floor(@level / 2)

  mod: (attr) ->
    Math.floor( @[attr] - 10 )

  getHealsCount: ->
    return '-' unless @character_class?
    @character_class.healsCount(@)

  getInitiative: ->
    Math.floor( @level / 2 ) + @mod('dex')