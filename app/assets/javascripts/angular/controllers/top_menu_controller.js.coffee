dndApp = angular.module 'dndApp'

class window.TopMenuController
  constructor: (@$scope, @Invites) ->
    @$scope.c = @

TopMenuController.$inject = ["$scope", "Invites"]

angular.module("dndApp").controller("TopMenuController", TopMenuController)    