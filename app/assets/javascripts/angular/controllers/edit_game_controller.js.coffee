class window.EditGameController
  constructor: (@$scope, @Game, @$injector, $routeParams) ->
    @$scope.game = Game.get(id: $routeParams.id)

EditGameController.$inject = ["$scope", "Game", "$injector", "$routeParams"]

angular.module("dndApp").controller("EditGameController", EditGameController)