#= require classes/figure

window.Creature = class extends Figure
  constructor: (creaturePrototype, tile) ->
    super(creaturePrototype.speed, tile)
    @name = 'The First One'