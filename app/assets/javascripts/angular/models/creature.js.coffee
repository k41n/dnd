class window.Creature
  constructor: (monster_resource) ->
    @data = monster_resource if monster_resource?
    @location = undefined
    @rotateable = false
    @installEvents()

  saveToJSON: =>
    skills = @data.skills
    res =
      data: @data
      location: @location
      skills: @skillsJSON()
    @data.skills = skills
    res

  loadFromJSON: (json, SkillLibrary, Zoo) =>
    @data = json.data
    @skills = []
    @location = json.location
    for skill in json.skills
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
      @data.hp -= params.damage
      if @data.hp <= 0
        @grid.deleteMonster(@)
      new CombatScroll("-#{params.damage}", '#ff0000', @location).act()
