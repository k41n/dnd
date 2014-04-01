class window.CreaturesBand
  constructor: (@$injector) ->

  loadCreatures: (grid) ->
    console.log grid
    @grid = grid
    @creatures = grid.creatures.slice(0)
    @creatures.push { p: {name: 'End of Turn'} }

  getCreatures: ->
    @creatures

  getActingCreature: ->
    @creatures[@grid.currentTurn]

  endTurn: (creature) ->
    creature.trigger 'endOfTurn'
    @grid.currentTurn += 1
    @endRound() if @getActingCreature().p.name == 'End of Turn'
    @grid.currentTurn

  endRound: ->
    @grid.currentTurn = 0
    for creature in @grid.creatures
      creature.trigger 'endOfRound'

  currentTurnNumber: ->
    @grid.currentTurn

CreaturesBand.$inject = ["$injector"]

angular.module("dndApp").service("CreaturesBand", CreaturesBand)