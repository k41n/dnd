dndApp = angular.module 'dndApp'

dndApp.controller 'GridController', [ '$scope', 'selectedTile', 'selectedCreature', 'moveService', 'battleService',  ($scope, selectedTile, selectedCreature, moveService, battleService) ->

  $scope.rows = 25
  $scope.cols = 25
  $scope.tileSet = new Array($scope.rows)
  for row in [0..$scope.rows]
    $scope.tileSet[row] = new Array($scope.cols)
    for col in [0..$scope.cols]
      $scope.tileSet[row][col] = new Tile({row: row, col: col})
  $scope.moveableTiles = []

  $scope.displayCreatureAtTile = (tile) ->
    tile.figure.name if tile.figure

  $scope.addFigureToGrid = (figure, tile) ->
    figure.tile = tile
    tile.figure = figure

  $scope.moveSelectedCreature = (targetTile) ->
    moveService.moveCreatureToTile(selectedCreature.get(), targetTile)
    moveService.clearMoveableTiles()

  $scope.setSelectedTile = (tile) ->
    unless tile.targetable or tile.moveable
      selectedTile.set tile
      selectedCreature.set(if tile.figure then tile.figure else null)

  $scope.clearSelectedTile = ->
    selectedTile.set null

  $scope.isActiveTile = (tile) ->
    selectedTile.get() == tile

  $scope.addFigureToGrid( (new Creature({speed: 6})), $scope.tileSet[2][2] )
  $scope.addFigureToGrid( (new Creature({speed: 6})), $scope.tileSet[3][3] )

  $scope.$on 'highlightMoveableTiles', ->
    moveService.highlightMoveableTiles($scope.tileSet)

  $scope.$on 'highlightTargetableTiles', ->
    battleService.highlightTargetableTiles($scope.tileSet)

]