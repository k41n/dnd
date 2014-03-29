class window.Creature
  constructor: (monster_resource) ->
    @p = monster_resource if monster_resource?
    @p ||= {}
    @i = {}
    @location = undefined
    @rotateable = false
    @installEvents()

  saveToJSON: =>
    console.log 'Creature::saveToJSON'
    console.log @
    res =
      instance: @i
      id: @p.id
      location: @location
      skills: @skillsJSON()
      type: 'monster'
    res

  loadFromJSON: (json, SkillLibrary, Zoo) =>
    console.log 'json = ', json
    @p = Zoo.monsters[json.id].p
    @skills = []
    @location = json.location
    for skill in json.skills
      s = SkillLibrary.create(skill)
      @skills.push s
    if json.skill_ids?
      for skill in json.skill_ids
        s = SkillLibrary.create(skill)
        @skills.push s

  skillsJSON: ->
    @skills ||= {}
    $.map @skills, (skill) ->
      skill.id

  setCoords: (location, grid) =>
    @grid = grid
    @location = location

  moveTo: (location) =>
    @setCoords(location)

  addAffect: (affect) =>
    @affects ||= []
    @affects.push affect

  trigger: (name, params) =>
    if @eventHandlers? and @eventHandlers[name]?
      for callback in @eventHandlers[name]
        return false unless callback(params)
    return true

  registerEventHandler: (name, callback) =>
    @eventHandlers ||= {}
    @eventHandlers[name] = new Array() unless @eventHandlers[name]?
    @eventHandlers[name].push callback


  neighbors: ->
    return [] unless @grid?
    $.grep @grid.creaturesInRadius(@location, 1), (c) =>
      c != @

  installEvents: ->
    @registerEventHandler 'received_damage', (params) =>
      console.log "#{@name} received #{params.damage} from #{params.enemy.name}"
      @hp -= params.damage
      if @hp <= 0
        @grid.deleteMonster(@)

  mod: (attr) ->
    Math.floor( @data[attr] - 10 )

