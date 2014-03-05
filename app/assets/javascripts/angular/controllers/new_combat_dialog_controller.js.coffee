class window.NewCombatDialogController
  constructor: (@$scope, @$modalInstance) ->
    @$scope.form = 
      name: ''

    @$scope.ok = =>
      @$modalInstance.close @$scope.form

    @$scope.cancel = =>
      @$modalInstance.dismiss 'cancel'

NewCombatDialogController.$inject = ["$scope", "$modalInstance"]

angular.module("dndApp").controller("NewCombatDialogController", NewCombatDialogController)