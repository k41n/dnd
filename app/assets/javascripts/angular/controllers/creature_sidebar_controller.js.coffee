dndApp = angular.module 'dndApp'

dndApp.controller 'CreatureSidebarController', ['$scope', 'selectedCreature', '$rootScope', ($scope, selectedCreature, $rootScope) ->

  $scope.selectedCreatureIsNotEmpty = ->
    $scope.selectedCreature = selectedCreature.get()
    $scope.selectedCreature != null

  $scope.highlightMoveableTiles = ->
    $rootScope.$broadcast('highlightMoveableTiles')

  $scope.hightlightAttackableTiles = ->
    $rootScope.$broadcast('highlightTargetableTiles')

]