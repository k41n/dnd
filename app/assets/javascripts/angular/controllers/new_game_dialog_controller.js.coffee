class window.NewGameDialogController
  constructor: (@$scope, @$modalInstance) ->
    @$scope.form = 
      name: ''

    @$scope.ok = =>
      @$modalInstance.close @$scope.form

    @$scope.cancel = =>
      @$modalInstance.dismiss 'cancel'

NewGameDialogController.$inject = ["$scope", "$modalInstance"]

angular.module("dndApp").controller("NewGameDialogController", NewGameDialogController)