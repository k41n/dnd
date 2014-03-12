class window.Creature
  constructor: (monster_resource) ->
    if monster_resource
      @name = monster_resource.name
      @description = monster_resource.description
      @avatar_url = monster_resource.avatar_url
      @skills = monster_resource.skills
    @location = undefined
    @ac = 10
    @skills ||= []

  saveToJSON: =>
    {
      ac: @ac
      name: @name
      description: @description
      avatar_url: @avatar_url
      location: @location
      skills: @skillsJSON()
    }

  loadFromJSON: (json) =>
    @ac = json.ac
    @name = json.name
    @description = json.description
    @avatar_url = json.avatar_url
    @location = json.location
    @skills = json.skills

  skillsJSON: ->
    ret = []
    for skill in @skills
      ret.push
        title: skill.title
        avatar_url: skill.avatar_url
    ret

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

  event: (name, params) =>
    console.log "#{@name} Received event #{name} with params", params
    if @eventHandlers? and @eventHandlers[name]?
      for callback in @eventHandlers[name]
        callback(params)

  registerEventHandler: (name, callback) =>
    console.log "Registering event handler on #{@name} for #{name}"
    @eventHandlers ||= {}
    @eventHandlers[name] = new Array() unless @eventHandlers[name]?
    @eventHandlers[name].push callback


  neighbors: ->
    return [] unless @grid?
    $.grep @grid.creaturesInRadius(@location, 1), (c) =>
      c != @



Creature.$inject = []

angular.module("dndApp").factory("Creature", -> new Creature())