class window.Creature
  constructor: (monster_resource) ->
    if monster_resource
      @name = monster_resource.name
      @description = monster_resource.description
      @avatar_url = monster_resource.avatar_url
      @hp = monster_resource.hp
      @ac = monster_resource.ac
      @dex = monster_resource.dex
      @skills = monster_resource.skills
    @location = undefined
    @skills ||= []

    @installEvents()

  saveToJSON: =>
    {
      ac: @ac
      hp: @hp
      dex: @dex
      name: @name
      description: @description
      avatar_url: @avatar_url
      location: @location
      skills: @skillsJSON()
    }

  loadFromJSON: (json, SkillLibrary) =>
    @ac = json.ac
    @hp = json.hp
    @dex = json.dex
    @name = json.name
    @description = json.description
    @avatar_url = json.avatar_url
    @location = json.location
    console.log 'json.skills', json.skills
    for skill in json.skills
      s = SkillLibrary.create(skill)
      console.log s
      @skills.push s

  skillsJSON: ->
    $.map @skills, (skill) ->
      skill.id

  setCoords: (x, y, grid) =>
    @grid = grid
    @location =
      x: x
      y: y

  moveTo: (x, y) =>
    @setCoords(x, y)

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
