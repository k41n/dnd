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
    console.log 'affects json', @affectsJSON()
    res =
      instance: @i
      id: @p.id
      location: @location
      skills: @skillsJSON()
      type: 'monster'
      affects: @affectsJSON()
    res

  loadFromJSON: (json) ->
    @i = json.instance
    @skills = []
    @affects = []
    @location = json.location
    for skill in json.skills
      s = @SkillLibrary.create(skill)
      @skills.push s
    for affect in json.affects
      @affects.push affect

  skillsJSON: ->
    @skills ||= {}
    $.map @skills, (skill) ->
      skill.id

  affectsJSON: ->
    ret = []
    if @affects
      $.map @affects, (affect) ->
        hash = {}
        $.map affect, (v, k) ->
          hash[k] = v unless k == 'applicator' || k == 'receiver'
#        hash.applicator = affect.applicator.i.id
#        hash.receiver = affect.receiver.i.id
        ret.push hash
    ret

  setCoords: (location, grid) ->
    @grid = grid
    @location = location

  moveTo: (location) ->
    @setCoords(location)

  addAffect: (affect) ->
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

  trigger: (name, params) ->
    if @eventHandlers? and @eventHandlers[name]?
      for callback in @eventHandlers[name]
        return false unless callback(params)
    return true

  registerEventHandler: (name, callback) ->
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
      console.log "#{@p.name} received #{params.damage} of damage"
      console.log "HP changes from #{@i.hp}"
      @i.hp -= params.damage
      console.log "to #{@i.hp}"
      if @i.hp <= 0
        @grid.deleteMonster(@)

  mod: (attr) ->
    Math.floor( @data[attr] - 10 )

Creature.$inject = ['SkillLibrary']

angular.module("dndApp").factory('Creature', (SkillLibrary) -> new Creature(SkillLibrary))