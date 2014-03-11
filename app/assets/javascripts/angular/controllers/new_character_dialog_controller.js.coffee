class window.NewCharacterDialogController
  constructor: (@$scope, @$modalInstance) ->
    @$scope.form = 
      name: ''

    @$scope.ok = =>
      @$modalInstance.close @$scope.form

    @$scope.cancel = =>
      @$modalInstance.dismiss 'cancel'

NewCharacterDialogController.$inject = ["$scope", "$modalInstance"]

angular.module("dndApp").controller("NewCharacterDialogController", NewCharacterDialogController)