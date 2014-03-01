dndApp = angular.module 'dndApp'

dndApp.controller 'GridController', [ '$scope', ($scope) ->

  $scope.rows = 25
  $scope.cols = 25
  $scope.tileSet = new Array($scope.rows)

  for row in [0..$scope.rows]
    $scope.tileSet[row] = new Array($scope.cols)
    for col in [0..$scope.cols]
      $scope.tileSet[row][col] = new Tile({x: row, y: col})

  $scope.displayFigureAtTile = (tile) ->
    tile.figure.name if tile.figure
]