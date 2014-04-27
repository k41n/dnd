class window.Combatant
  constructor: (@SkillLibrary, @Logger) ->
    @revokeActions()
    @hasTurn = false

  hasAction: (actionType) ->
    return false unless @availableActions?
    @availableActions[actionType]

  setCoords: (location, grid) ->
    @grid = grid
    @location = location

  grantActions: ->
    @availableActions = 
      main: true
      aux: true
      move: true

  revokeActions: ->
    @availableActions = 
      main: false
      aux: false
      move: false

  revokeAction: (actionType) ->
    @availableActions[actionType] = false

  installEventHandlers: ->
    @registerEventHandler 'start_of_turn', (params) =>
      @Logger.info "#{@p.name}'s turn started"
      @hasTurn = true
      @grantActions()

    @registerEventHandler 'received_damage', (params) =>
      @Logger.info "#{@p.name} received #{params.damage} of damage"
      @Logger.info "HP changes from #{@i.hp}"
      @i.hp -= params.damage
      @Logger.info "to #{@i.hp}"
      if @i.hp <= 0
        @grid.deleteMonster(@)

    @registerEventHandler 'endOfTurn', =>
      @hasTurn = false
      true #We should return true to avoid interrupting callback queue

  moveTo: (location) ->
    @setCoords(location)
    @revokeAction('move')

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

  affectsJSON: ->
    ret = []
    if @affects
      $.map @affects, (affect) ->
        hash = {}
        $.map affect, (v, k) ->
          hash[k] = v unless k == 'applicator' || k == 'receiver'
        ret.push hash
    ret

  addSkill: (skill) ->
    @skills ||= {}
    @skills[skill.id] = skill
    @p.skill_ids = @skillIds()
    console.log "skill = ", skill
    skill.assignTo @
    skill

  skillIds: ->
    if @skills? && Object.keys(@skills)?
      Object.keys(@skills).map (k) ->
        parseInt(k)
    else 
      []

  addSkillByJsClass: (jsClass) ->
    skillToAdd = @SkillLibrary.getByJsClass(jsClass)
    console.log 'skillToAdd = ', skillToAdd
    @addSkill skillToAdd if skillToAdd?

