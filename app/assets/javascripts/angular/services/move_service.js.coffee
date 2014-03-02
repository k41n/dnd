dndApp = angular.module "dndApp"

dndApp.service "moveService", [ 'selectedCreature', 'selectedTile', (selectedCreature, selectedTile) ->

  moveableTiles = []

  highlightMoveableTiles: (tileSet) ->
    figure = selectedCreature.get()
    if figure
      position = figure.tile
      speed = figure.speed
      startCol = position.col - speed
      steps = speed*2 + 1
      height = 1

      for step in [1..steps]
        tile = tileSet[position.row][startCol]
        if tile
          tile.moveable = true
          moveableTiles.push tile
          if height >= 3
            startRow = tile.row - Math.floor(height/2)
            for j in [1..height]
              vertTile = tileSet[startRow]
              if vertTile
                vertTile = tileSet[startRow][tile.col]
                vertTile.moveable = true
                moveableTiles.push vertTile
                vertTile = null
              startRow += 1
        startCol += 1

        if step*2 > steps then height -= 2 else height += 2
    else
      clearMoveableTiles()

  clearMoveableTiles: () ->
    for tile in moveableTiles
      tile.moveable = false

  moveCreatureToTile: (creature, targetTile) ->
    if targetTile.moveable and targetTile != selectedTile.get()
      creature.tile.figure = null
      creature.tile = targetTile
      targetTile.figure = creature
      selectedTile.set null
      selectedCreature.set null

]
