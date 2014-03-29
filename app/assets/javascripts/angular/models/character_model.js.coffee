class window.CharacterModel
  constructor: (@SkillLibrary, @Perks) ->
    console.log 'Constructor'

  new: (permanent_data, instance_data) ->
    ret = new CharacterModel(@SkillLibrary, @Perks)
    angular.extend ret, @
    ret.p = permanent_data
    ret.i = instance_data
    ret.perks = {}
    if ret.p.perk_ids?
      for perk_id in ret.p.perk_ids
        console.log 'Filling in perk with id', perk_id
        perk = @Perks.getById(perk_id)
        if perk?
          ret.perks[perk.id] = perk

    ret.skills = {}          
    if ret.p.skill_ids?
      for skill_id in ret.p.skill_ids
        console.log 'Filling in perk with id', perk_id
        skill = @SkillLibrary.getById(skill_id)
        if skill?
          ret.skills[skill.id] = skill
    ret

  setCoords: (location, grid) ->
    console.log 'setCoords', location, grid
    @grid = grid
    @location = location
    console.log '@', @

  saveToJSON: ->
    res =
      id: @p.id
      type: 'character'
      location: @location
    res

  loadFromJSON: (json, SkillLibrary, Zoo, Chars) =>
    @data = Chars.characters(json.id)
    @skills = {}
    if @data.skill_ids
      for skill_id in @data.skill_ids
        @addSkill @SkillLibrary.skills[skill_id]

  maxHP: ->
    return '-' unless @character_class?
    @calculateHP(@)

  getAC: ->
    armor_bonus = if @armor? then @armor.ac_bonus else 0 
    shield_bonus = if @shield? then @shield.ac_bonus else 0 
    if !@armor? or @armor.armor_type == 'Light'
      return 10 + armor_bonus + shield_bonus + Math.max(@mod('int'), @mod('dex')) + Math.floor(@p.level / 2)
    else
      return 10 + armor_bonus + shield_bonus + Math.floor(@p.level / 2)

  getStamina: ->
    bonus = if @staminaBonus? then @staminaBonus else 0
    return 10 + bonus + Math.max(@mod('str'), @mod('con')) + Math.floor(@p.level / 2)

  getReaction: ->
    bonus = if @reactionBonus? then @reactionBonus else 0
    return 10 + bonus + Math.max(@mod('dex'), @mod('int')) + Math.floor(@p.level / 2)

  getWill: ->
    bonus = if @willBonus then @willBonus else 0
    return 10 + bonus + Math.max(@mod('wis'), @mod('cha')) + Math.floor(@p.level / 2)

  mod: (attr) ->
    Math.floor( (@p[attr] - 10) / 2 )

  getHealsCount: ->
    return '-' unless @character_class?
    @character_class.healsCount(@)

  getInitiative: ->
    Math.floor( @p.level / 2 ) + @mod('dex')

  getWeaponDamage: ->
    return '-' unless @weapon
    "#{@weapon.damage_count}d#{@weapon.damage_dice}"

  getMasteryIn: (ability) ->
    train_bonus = if @abilityTrainings? && @abilityTrainings[ability.name]? && @abilityTrainings[ability.name] then 5 else 0
    train_bonus += @abilityBonus[ability.name] if @abilityBonus? && @abilityBonus[ability.name]?
    Math.floor(@p.level / 2) + @mod(ability.dependent_on_stat) + train_bonus

  getTrainingsCount: ->
    trained_abilities = 0
    for k,v of @abilityTrainings
      trained_abilities += 1 if v
    @trainings_count - trained_abilities

  canTrain: (ability) ->
    return false unless @character_class?
    @abilityTrainings ||= {}
    @getTrainingsCount() > 0 && @abilityTrainings[ability.name] != true && @character_class.trainable_abilities.indexOf(ability.id) != -1

  canUntrain: (ability) ->
    return false unless @character_class?
    @abilityTrainings[ability.name] && @forcedTrainings.indexOf(ability.name) == -1

  train: (ability) ->
    if @canTrain(ability)
      @abilityTrainings[ability.name] = true

  untrain: (ability) ->
    if @canUntrain(ability)
      delete @abilityTrainings[ability.name]

  getStat: (stat_name) ->
    bonus = if @statBonuses? && @statBonuses[stat_name]? then @statBonuses[stat_name] else 0
    @p[stat_name] + bonus

  trainedAbilityIds: (CharacterAbilities) ->
    ret = []
    for k,v of @abilityTrainings
      ret.push CharacterAbilities.findByName(k).id if v? && v
    ret

  availablePerks: (Perks) ->
    ret = []
    @perks ||= {}
    for k,v of Perks.perks
      ret.push v if v.pickable(@) && !@perks[k]?
    ret

  perkIds: ->
    if @perks? && Object.keys(@perks)?
      Object.keys(@perks).map (k) ->
        parseInt(k)
    else 
      []

  addPerk: (perk) ->
    @perks ||= {}
    @perks[perk.id] = perk

  removePerk: (perk) ->
    delete @perks[perk.id]

  getPerks: ->
    @perks

  availableSkills: (cooldown_type) ->
    ret = []
    @skills ||= {}
    console.log 'availableSkills'
    console.log '@SkillLibrary.skills', @SkillLibrary.skills
    for k,v of @SkillLibrary.skills
      ret.push v if v.pickable(@) && !@skills[k]? && v.cooldown_type == cooldown_type
    ret

  addSkill: (skill) ->
    @skills[skill.id] = skill
    @p.skill_ids = @skillIds()

  removeSkill: (skill) ->
    delete @skills[skill.id]
    @p.skill_ids = @skillIds()

  getSkills: (cooldown_type) ->
    ret = {}
    for k,v of @skills
      ret[k] = v if v.cooldown_type == cooldown_type
    ret

  skillIds: ->
    if @skills? && Object.keys(@skills)?
      Object.keys(@skills).map (k) ->
        parseInt(k)
    else 
      []

  canIncrease: (attr) ->
    (@priceOfIncrementFrom(@p[attr]) <= @p.stat_points) || (@p.stat_increment_points > 0)

  canDecrease: (attr) ->
    @p[attr] > 8

  priceOfIncrementFrom: (previousValue) ->
    return 1 if previousValue == 8
    return 1 if previousValue == 9
    return 1 if previousValue == 10
    return 1 if previousValue == 11
    return 1 if previousValue == 12
    return 2 if previousValue == 13
    return 2 if previousValue == 14
    return 2 if previousValue == 15
    return 3 if previousValue == 16
    return 4 if previousValue == 17
    return 4 if previousValue == 18
    return 5 if previousValue == 19
    return 5 if previousValue == 20
    return 6 if previousValue == 21
    return 6 if previousValue == 22

  increase: (attr) ->
    previousValue = @p[attr]
    price = @priceOfIncrementFrom(previousValue)
    if @priceOfIncrementFrom(@p[attr]) <= @p.stat_points
      @p.stat_points -= price
    else
      @p.stat_increment_points -= 1
    @p[attr] += 1      

  decrease: (attr, editedCharacter) ->
    previousValue = @p[attr]
    price = @priceOfIncrementFrom(previousValue - 1)
    if @p.stat_increment_points >= 2
      @p.stat_points += price
    else
      @p.stat_increment_points += 1
    @p[attr] -= 1      

CharacterModel.$inject = ['SkillLibrary', 'Perks']

angular.module("dndApp").factory('CharacterModel', (SkillLibrary, Perks) -> new CharacterModel(SkillLibrary, Perks))