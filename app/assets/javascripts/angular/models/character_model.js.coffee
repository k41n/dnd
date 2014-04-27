#= require ./combatant

class window.CharacterModel extends Combatant
  constructor: (@$injector) ->
    @SkillLibrary = @$injector.get('SkillLibrary')
    @Perks = @$injector.get('Perks')
    @Logger = @$injector.get('Logger')
    @Weapons = @$injector.get('Weapons')
    @Racing = @$injector.get('Racing')
    @CharacterAbilities = @$injector.get('CharacterAbilities')
    @CharacterClasses = @$injector.get('CharacterClasses')
    @$q = @$injector.get('$q')
    super()

  new: (permanent_data, instance_data) ->
    ret = new CharacterModel(@$injector)
    @instantiation = @$q.defer()

    angular.extend ret, @
    ret.p ||= {}
    for k,v of permanent_data
      ret.p[k] = v
    if instance_data?
      for k,v of instance_data
        ret.i[k] = v

    unless ret.i?
      ret.i = {}
      angular.extend ret.i, ret.p
    ret.perks = {}
    if ret.p.perk_ids?
      for perk_id in ret.p.perk_ids
        perk = @Perks.getById(perk_id)
        if perk?
          ret.perks[perk.id] = perk

    ret.skills ||= {}
    ret.p.skill_ids ||= []
    for skill_id in ret.p.skill_ids
      skill = @SkillLibrary.getById(skill_id)
      if skill?
        ret.addSkill skill

    if ret.p.weapon_id
      @Weapons.loading.$promise.then =>      
        ret.weapon = @Weapons.create(ret.p.weapon_id)
        @weaponInstantiated = true
        @checkInstantiationComplete()

    ret.hostile = false

    @CharacterClasses.loading.$promise.then =>
      ret.character_class = @CharacterClasses.create(ret.p.character_class_id)
      @characterClassInstantiated = true
      @checkInstantiationComplete()

    ret.race = @Racing.create(ret.p.race_id)

    if permanent_data.character_ability_ids?
      for id in permanent_data.character_ability_ids
        ret.train @CharacterAbilities.character_abilities[id]
    ret.configurePerks()
    ret.installEventHandlers()

    ret

  checkInstantiationComplete: ->
    if @characterClassInstantiated && @weaponInstantiated
      @instantiation.resolve()

  saveToJSON: ->
    res =
      id: @p.id
      type: 'character'
      location: @location
      hasTurn: @hasTurn
      availableActions: @availableActions
      skills: @skillsJSON()
    res

  loadFromJSON: (json, SkillLibrary, Zoo, Chars) ->
    @hasTurn = json.hasTurn
    @availableActions = json.availableActions
    for s in json.skills
      skill = SkillLibrary.create(s.id)
      @addSkill skill
      skill.loadFromJSON(s)

  skillsJSON: ->
    ret = []
    for _, skill of @skills
      ret.push skill.saveToJSON()
    ret

  maxHP: ->
    return '-' unless @character_class?
    @character_class.calculateHP(@)

  getAC: ->
    armor_bonus = if @armor? then @armor.ac_bonus else 0 
    shield_bonus = if @shield? then @shield.ac_bonus else 0 
    if @affects?
      for affect in @affects
        armor_bonus += affect.getAcBonus()
    if !@armor? or @armor.armor_type == 'Light'
      return 10 + armor_bonus + shield_bonus + Math.max(@mod('int'), @mod('dex')) + @halfLevel()
    else
      return 10 + armor_bonus + shield_bonus + @halfLevel()

  getStamina: ->
    bonus = if @staminaBonus? then @staminaBonus else 0
    return 10 + bonus + Math.max(@mod('str'), @mod('con')) + Math.floor(@p.level / 2)

  getReaction: ->
    bonus = 0
    if @character_class?
      bonus += @character_class.reactionBonus()
    return 10 + bonus + Math.max(@mod('dex'), @mod('int')) + @halfLevel()

  getWill: ->
    bonus = if @willBonus then @willBonus else 0
    return 10 + bonus + Math.max(@mod('wis'), @mod('cha')) + Math.floor(@p.level / 2)

  mod: (attr) ->
    Math.floor( (@getStat(attr) - 10) / 2 )

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
    if @race
      train_bonus += @race.abilityBonus(ability.name)
    if @character_class?
      train_bonus += 5 if @character_class.forcedTrainings().indexOf(ability.name) != -1
    @halfLevel() + @mod(ability.dependent_on_stat) + train_bonus

  isTrained: (ability) ->
    return true if @abilityTrainings? && @abilityTrainings[ability.name]? && @abilityTrainings[ability.name]
    return true if @character_class? && @character_class.forcedTrainings().indexOf(ability.name) != -1
    false

  getTrainingsCount: ->
    trained_abilities = 0

    class_trainings = @character_class.classTrainingsCount()
    for k,v of @abilityTrainings
      trained_abilities += 1 if v
    class_trainings - trained_abilities

  canTrain: (ability) ->
    return false unless @character_class?
    @abilityTrainings ||= {}
    @getTrainingsCount() > 0 && @abilityTrainings[ability.name] != true && @character_class.trainable_abilities.indexOf(ability.id) != -1 && @character_class.forcedTrainings().indexOf(ability.name) == -1


  canUntrain: (ability) ->
    return false unless @character_class?
    @abilityTrainings[ability.name] && @character_class.forcedTrainings().indexOf(ability.name) == -1

  train: (ability) ->
    if @canTrain(ability)
      @abilityTrainings[ability.name] = true

  untrain: (ability) ->
    if @canUntrain(ability)
      delete @abilityTrainings[ability.name]

  getStat: (stat_name) ->
    bonus = 0
    if @perks?
      for id, perk of @perks
        bonus += perk.getBonus(stat_name)
    if @race?
      bonus += @race.statBonus(stat_name)
    ( @p[stat_name] || 0 ) + bonus

  trainedAbilityIds: (CharacterAbilities) ->
    ret = []
    for k,v of @abilityTrainings
      ret.push CharacterAbilities.findByName(k).id if v? && v
    ret

  availablePerks: (Perks) ->
    ret = []
    for k,v of Perks.perks
      ret.push v if v.pickable(@) && !@perks[k]?
    ret

  autoPickPerks: (Perks) ->
    @perks ||= {}    
    for k,v of Perks.perks
      if v.pickable(@) && !@perks[k]? && v.autoPickable()
        @addPerk(v)
      if @perks[k] && !v.pickable(@) && v.autoPickable()
        @removePerk(v) 

  perkIds: ->
    if @perks? && Object.keys(@perks)?
      Object.keys(@perks).map (k) ->
        parseInt(k)
    else 
      []

  addPerk: (perk) ->
    @perks ||= {}
    @perks[perk.id] = perk
    perk.onPicked(@)

  removePerk: (perk) ->
    perk.onRemoved(@)
    delete @perks[perk.id]

  getPerks: ->
    @perks

  availableSkills: (cooldown_type) ->
    ret = []
    @skills ||= {}
    for k,v of @SkillLibrary.skills
      ret.push v if v.pickable(@) && !@skills[k]? && v.cooldown_type == cooldown_type
    ret

  removeSkill: (skill) ->
    delete @skills[skill.id]
    @p.skill_ids = @skillIds()

  getSkills: (cooldown_type) ->
    ret = {}
    for k,v of @skills
      ret[k] = v if v.cooldown_type == cooldown_type
    ret

  canIncrease: (attr) ->
    @priceOfIncrementFrom(@p[attr]) <= @p.stat_points

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
    @p.stat_points -= price
    @p[attr] += 1      

  decrease: (attr, editedCharacter) ->
    previousValue = @p[attr]
    price = @priceOfIncrementFrom(previousValue - 1)
    @p.stat_points += price
    @p[attr] -= 1      

  addAffect: (affect) ->
    @affects ||= []
    @affects.push affect

  halfLevel: ->
    Math.floor( ( @i.level || 0 ) / 2.0 )

  skillPoints: (cooldown_type) ->
    return 2 - Object.keys(@getSkills(cooldown_type)).length if cooldown_type == 'unlimited'
    return 1 - Object.keys(@getSkills(cooldown_type)).length if cooldown_type == 'instant'
    if cooldown_type == 'combat'
      if @p.level < 3
        @total = 1
      else
        @total = 2
      return @total - Object.keys(@getSkills(cooldown_type)).length 
    if cooldown_type == 'day'
      if @p.level < 5
        @total = 1
      else
        @total = 2
      return @total - Object.keys(@getSkills(cooldown_type)).length 

  levelUp: ->
    @p.level += 1 if @p.level < 5
    @autoPickPerks(@Perks)

  levelDown: ->
    @p.level -= 1 if @p.level > 1
    @autoPickPerks(@Perks)

  getSpeed: ->
    if @race
      @race.getSpeed()
    else
      '-'

  configurePerks: ->
    if @perks? && @p.perk_settings?
      @p.perk_settings = JSON.parse(@p.perk_settings)
      for id, perk of @perks
        if @p.perk_settings[id]?
          @perks[id].configure(@p.perk_settings[id])

  perkSettings: ->
    ret = {}
    if @perks?
      for id, perk of @perks
        ret[id] = perk.configuration()
    JSON.stringify(ret)

  getAvailablePerks: ->
    @getTotalPerks() - @getPickedPerks()

  getTotalPerks: ->
    Math.floor((@p.level + 2) / 2)

  getPickedPerks: ->
    if @perks?
      ret = 0
      for id, perk in @perks
        ret += 1 unless perk.autoPickable()
      return ret
    else
      0

  hasPerk: (perk) ->
    @perks[perk.id]?

  damageBonus: ->
    ret = 0
    if @perks?
      for id, perk of @perks
        ret += perk.damageBonus(@)
    ret

  toHitBonus: ->
    ret = 0
    if @perks?
      for id, perk of @perks
        ret += perk.toHitBonus(@)
    ret

angular.module("dndApp").factory('CharacterModel', ($injector) -> new CharacterModel($injector))