class window.DeleteGameDialogController
  constructor: (@$scope, @$modalInstance) ->
    @$scope.ok = =>
      @$modalInstance.close 'ok'

    @$scope.cancel = =>
      @$modalInstance.dismiss 'cancel'

DeleteGameDialogController.$inject = ["$scope", "$modalInstance"]

angular.module("dndApp").controller("DeleteGameDialogController", DeleteGameDialogController)