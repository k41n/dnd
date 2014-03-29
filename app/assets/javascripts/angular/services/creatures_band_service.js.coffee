class window.CreaturesBand
  constructor: (@$injector) ->

  loadCreatures: (grid) ->
    @grid = grid
    @creatures = grid.creatures.slice(0)
    @creatures.push { p: {name: 'End of Turn'} }
    @current = 0

  getCreatures: ->
    @creatures

  getActingCreature: ->
    @creatures[@current]

  endTurn: (creature) ->
    creature.trigger 'endOfTurn'
    @current += 1
    @endRound() if @getActingCreature().p.name == 'End of Turn'
    @current

  endRound: ->
    @current = 0
    for creature in @grid.creatures
      creature.trigger 'endOfRound'

CreaturesBand.$inject = ["$injector"]

angular.module("dndApp").service("CreaturesBand", CreaturesBand)