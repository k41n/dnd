#= require ./combatant

class window.Creature extends Combatant
  constructor: (@SkillLibrary, @Logger) ->
    super(@SkillLibrary, @Logger)

  new: (permanent, instance) ->
    ret = new Creature(@SkillLibrary)
    angular.extend ret, @
    ret.p = permanent
    ret.i = instance
    unless ret.i?
      ret.i = {}
      angular.extend ret.i, ret.p

    ret.location = undefined
    ret.rotateable = false
    ret.installEventHandlers()
    ret

  getAC: ->
    armor_bonus = 0
    if @affects?
      for affect in @affects
        armor_bonus += affect.getAcBonus()
    return @p.ac + armor_bonus

  toHitBonus: ->
    @i.toHitBonus ||= 0
    @i.toHitBonus

  saveToJSON: ->
    res =
      instance: @i
      id: @p.id
      location: @location
      skills: @skillsJSON()
      type: 'monster'
      affects: @affectsJSON()
      hasTurn: @hasTurn
      available_actions: @availableActions
    res

  loadFromJSON: (json) ->
    @i = json.instance
    @skills = []
    @affects = []
    @location = json.location
    @hasTurn = json.hasTurn
    @availableActions = json.available_actions
    for skill in json.skills
      s = @SkillLibrary.create(skill)
      @skills.push s
    for affect in json.affects
      @affects.push affect

  skillsJSON: ->
    @skills ||= {}
    $.map @skills, (skill) ->
      skill.id

  mod: (attr) ->
    Math.floor( @data[attr] - 10 )

Creature.$inject = ['SkillLibrary', 'Logger']

angular.module("dndApp").factory('Creature', (SkillLibrary, Logger) -> new Creature(SkillLibrary, Logger))