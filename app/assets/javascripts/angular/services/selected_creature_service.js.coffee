dndApp = angular.module "dndApp"

dndApp.service "selectedCreature", ->

  creature = null

  get: ->
    creature
  set: (newVal) ->
    creature = newVal
