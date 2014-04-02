dndApp = angular.module 'dndApp'

dndApp.controller 'HumanFlexibilityDialog', ['$scope', '$modalInstance', ($scope, $modalInstance) ->
  $scope.form = 
    stat: ''

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
