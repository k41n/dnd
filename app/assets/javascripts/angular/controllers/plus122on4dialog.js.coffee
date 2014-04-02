dndApp = angular.module 'dndApp'

dndApp.controller 'Plus122On4Dialog', ['$scope', '$modalInstance', ($scope, $modalInstance) ->
  $scope.form = 
    stat1: ''
    stat2: ''

  $scope.stats = [
    'str',
    'con',
    'int',
    'wis',
    'dex',
    'cha'
  ]

  $scope.ok = ->
    $modalInstance.close $scope.form

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
]
