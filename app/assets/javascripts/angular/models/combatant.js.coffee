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

