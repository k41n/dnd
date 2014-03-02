dndApp = angular.module "dndApp"

dndApp.service "moveService", [ 'selectedCreature', 'selectedTile', (selectedCreature, selectedTile) ->

  targetableTiles = []

  highlightTargetableTiles: (tileSet) ->


  clearTargetableTiles: () ->
    for tile in targetableTiles
      tile.attackable = false

]
