class window.Cell
  constructor: () ->
    @creature = null

  addCreature: (creature) ->
    @creature = creature

Cell.$inject = []

angular.module("dndApp").factory("Cell", -> new Cell())