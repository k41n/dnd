class window.Cell
  constructor: () ->
    @creature = null
    @moveable = false
    @enemy_moveable = false

  addCreature: (creature) ->
    @creature = creature

  saveToJSON: =>
    {
      moveability: @moveability
      enemy_moveable: @enemy_moveable
    }

  loadFromJSON: (json) =>
    @moveability = json.moveability
    @enemy_moveable = json.enemy_moveable

  hasCreature: ->
    @creature? && @creature


Cell.$inject = []

angular.module("dndApp").factory("Cell", -> new Cell())