dndApp = angular.module "dndApp"

dndApp.service "selectedTile", ->

  tile = null

  get: ->
    tile
  set: (newVal) ->
    tile = newVal
