class window.CreaturesBand
  constructor: (@$injector) ->

  loadCreatures: (creatures) ->
    @creatures = creatures
    @creatures.push { data: {name: 'Конец хода'} }
    @actingCreature = @creatures[0]

  getCreatures: ->
    @creatures

  getActingCreature: ->
    @actingCreature


CreaturesBand.$inject = ["$injector"]

angular.module("dndApp").service("CreaturesBand", CreaturesBand)