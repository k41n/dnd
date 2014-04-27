class window.CreaturesBand
  constructor: (@$injector) ->

  loadCreatures: (grid) ->
    @grid = grid
    @creatures = []
    ret = []
    for _,v of grid.creatures
      ret.push v
    @creatures = ret.slice(0)
    @creatures.push { p: {name: 'End of Turn'} }
    c = @getActingCreature()    
    console.log "c.hasTurn = #{c.hasTurn}"
    unless c.hasTurn
      c.trigger('start_of_turn') 

  getCreatures: ->
    @creatures

  getActingCreature: ->
    @creatures[@grid.currentTurn]

  endTurn: (creature) ->
    creature.trigger 'endOfTurn'
    @grid.currentTurn += 1
    @endRound() if @getActingCreature().p.name == 'End of Turn'
    c = @getActingCreature()    
    unless c.hasTurn
      c.trigger('start_of_turn') 
    @grid.currentTurn

  endRound: ->
    @grid.currentTurn = 0
    for creature in @grid.creatures
      creature.trigger 'endOfRound'

  currentTurnNumber: ->
    @grid.currentTurn

CreaturesBand.$inject = ["$injector"]

angular.module("dndApp").service("CreaturesBand", CreaturesBand)