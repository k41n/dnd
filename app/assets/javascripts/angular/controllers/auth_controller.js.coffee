dndApp = angular.module 'dndApp'

dndApp.controller 'LoginDialogController', ['$scope', '$modalInstance', ($scope, $modalInstance) ->
  $scope.form =
    email: ''
    password: ''
  $scope.ok = ->
    $modalInstance.close $scope.form

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
]

dndApp.controller 'AuthController', [ '$scope', 'current_user', '$modal', ($scope, current_user, $modal) ->
  $scope.currentUserService = current_user
  $scope.currentUser = () ->
    $scope.currentUserService.currentUser || {}

  $scope.email = ''
  $scope.password = ''

  $scope.login = ->
    $scope.currentUserService.login($scope.email, $scope.password)

  $scope.logout = ->
    $scope.currentUserService.logout()

  $scope.$on 'show_login', ->
    $scope.showLoginDialog()

  $scope.showLoginDialog = () ->
    modalInstance = $modal.open
      templateUrl: '/login_dialog.html'
      controller: 'LoginDialogController'
    modalInstance.result.then (requisites) ->
      $scope.email = requisites.email
      $scope.password = requisites.password
      $scope.login()

  $scope.currentUserService.loginLocal()

]