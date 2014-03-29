class window.Creature
  constructor: (@SkillLibrary) ->
    @

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
    ret.installEvents()
    ret

  toHitBonus: ->
    @i.toHitBonus ||= 0
    @i.toHitBonus

  saveToJSON: ->
    console.log 'Saving to json', @
    res =
      instance: @i
      id: @p.id
      location: @location
      skills: @skillsJSON()
      type: 'monster'
    res

  loadFromJSON: (json) ->
    @i = json.instance
    @skills = []
    @location = json.location
    for skill in json.skills
      s = @SkillLibrary.create(skill)
      @skills.push s

  skillsJSON: ->
    @skills ||= {}
    $.map @skills, (skill) ->
      skill.id

  setCoords: (location, grid) ->
    @grid = grid
    @location = location

  moveTo: (location) ->
    @setCoords(location)

  addAffect: (affect) ->
    @affects ||= []
    @affects.push affect

  deleteAffect: (affect) ->
    @affects ||= []
    index = @affects.indexOf(affect)
    @affects.splice(index,1)

  affectNames: ->
    @affects ||= []
    $.map @affects, (a) ->
      a.name

  affectTypes: ->
    @affects ||= []
    $.map @affects, (a) ->
      a.type

  trigger: (name, params) =>
    if @eventHandlers? and @eventHandlers[name]?
      for callback in @eventHandlers[name]
        return false unless callback(params)
    return true

  registerEventHandler: (name, callback) =>
    @eventHandlers ||= {}
    @eventHandlers[name] = new Array() unless @eventHandlers[name]?
    @eventHandlers[name].push callback

  neighbors: (range) ->
    return [] unless @grid?
    $.grep @grid.creaturesInRadius(@location, (range || 1) ), (c) =>
      c != @

  hostileNeighbours: ->
    return [] unless @grid?
    $.grep @grid.creaturesInRadius(@location, 1), (c) =>
      c != @ && c.hostile

  installEvents: ->
    @registerEventHandler 'received_damage', (params) =>
      @i.hp -= params.damage
      if @i.hp <= 0
        @grid.deleteMonster(@)

  mod: (attr) ->
    Math.floor( @data[attr] - 10 )

Creature.$inject = ['SkillLibrary']

angular.module("dndApp").factory('Creature', (SkillLibrary) -> new Creature(SkillLibrary))