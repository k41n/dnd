dndApp = angular.module 'dndApp'

dndApp.controller 'RogueTacticsDialog', ['$scope', '$modalInstance', ($scope, $modalInstance) ->
  $scope.form = 
    stat: ''

  $scope.ok = ->
    $modalInstance.close $scope.form

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
]
