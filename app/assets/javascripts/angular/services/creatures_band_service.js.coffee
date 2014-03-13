class window.CreaturesBand
  constructor: (@$injector) ->

  loadCreatures: (@creatures) ->

  getCreatures: ->
    @creatures


CreaturesBand.$inject = ["$injector"]

angular.module("dndApp").service("CreaturesBand", CreaturesBand)