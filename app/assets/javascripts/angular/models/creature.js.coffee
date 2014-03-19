class window.Creature
  constructor: (monster_resource) ->
    @data = monster_resource if monster_resource?
    @location = undefined
    @rotation = 'north'
    @rotateable = false
    @installEvents()

  saveToJSON: =>
    {
      data: @data
      location: @location
      skills: @skillsJSON()
    }

  loadFromJSON: (json, SkillLibrary, Zoo) =>
    @data = json.data
    @location = json.location
    for skill in json.skills
      s = SkillLibrary.create(skill)
      @data.skills.push s

  skillsJSON: ->
    @data ||= {}
    @data.skills ||= {}
    $.map @data.skills, (skill) ->
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
    console.log "#{@name} Received event #{name} with params", params
    if @eventHandlers? and @eventHandlers[name]?
      for callback in @eventHandlers[name]
        return false unless callback(params)
    return true

  registerEventHandler: (name, callback) =>
    console.log "Registering event handler on #{@name} for #{name}"
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
