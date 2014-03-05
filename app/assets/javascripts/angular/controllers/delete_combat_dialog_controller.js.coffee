class window.DeleteCombatDialogController
  constructor: (@$scope, @$modalInstance) ->
    @$scope.ok = =>
      @$modalInstance.close 'ok'

    @$scope.cancel = =>
      @$modalInstance.dismiss 'cancel'

DeleteCombatDialogController.$inject = ["$scope", "$modalInstance"]

angular.module("dndApp").controller("DeleteCombatDialogController", DeleteCombatDialogController)