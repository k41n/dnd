dndApp = angular.module 'dndApp'

dndApp.controller 'GridController', [ '$scope', ($scope) ->

  $scope.rows = 25
  $scope.cols = 25
  $scope.tileSet = new Array($scope.rows)
  for row in [0..$scope.rows]
    $scope.tileSet[row] = new Array($scope.cols)
    for col in [0..$scope.cols]
      $scope.tileSet[row][col] = new Tile({row: row, col: col})
  $scope.selectedTile = null
  $scope.selectedFigure = null
  $scope.moveableTiles = []

  $scope.displayFigureAtTile = (tile) ->
    tile.figure.name if tile.figure

  $scope.addFigureToGrid = (figure, tile) ->
    figure.tile = tile
    tile.figure = figure

  $scope.moveFigure = (figure, targetTile) ->
    if targetTile.moveable and targetTile != $scope.selectedTile
      figure.tile.figure = null
      figure.tile = targetTile
      targetTile.figure = figure
      $scope.selectedTile = null
      $scope.selectedFigure = null
      clearMoveableTiles()

  $scope.moveSelectedFigure = (tile) ->
    $scope.moveFigure($scope.selectedFigure, tile) if $scope.selectedFigure

  $scope.setSelectedTile = (tile) ->
    unless tile.targetable or tile.moveable
      $scope.selectedTile = tile
      $scope.selectedFigure = if tile.figure then tile.figure else null
    markMoveableTiles()

  $scope.clearSelectedTile = ->
    $scope.selectedTile = null

  $scope.addFigureToGrid( (new Creature({speed: 6})), $scope.tileSet[2][2] )


  markMoveableTiles = ->
    figure = $scope.selectedFigure
    if figure
      position = figure.tile
      speed = figure.speed
      startCol = position.col - speed
      steps = speed*2 + 1
      height = 1

      for step in [1..steps]
        tile = $scope.tileSet[position.row][startCol]
        if tile
          tile.moveable = true
          $scope.moveableTiles.push tile
          if height >= 3
            startRow = tile.row - Math.floor(height/2)
            for j in [1..height]
              vertTile = $scope.tileSet[startRow]
              if vertTile
                vertTile = $scope.tileSet[startRow][tile.col]
                vertTile.moveable = true
                $scope.moveableTiles.push vertTile
                vertTile = null
              startRow += 1
        startCol += 1

        if step*2 > steps then height -= 2 else height += 2
    else
      clearMoveableTiles()

  clearMoveableTiles = ->
    for tile in $scope.moveableTiles
      tile.moveable = false

]