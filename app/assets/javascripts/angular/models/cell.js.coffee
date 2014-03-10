class window.Cell
  constructor: () ->
    @creature = null

  addCreature: (creature) ->
    @creature = creature

  saveToJSON: =>
    {
      moveability: @moveability
    }

  loadFromJSON: (json) =>
    @moveability = json.moveability

  hasCreature: ->
    @creature? && @creature


Cell.$inject = []

angular.module("dndApp").factory("Cell", -> new Cell())