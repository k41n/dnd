class window.PlayersController
  constructor: (@$scope, @Player, @$injector) ->
    @$scope.players = @Player.query()

PlayersController.$inject = ["$scope", "Player", "$injector"]

angular.module("dndApp").controller("PlayersController", PlayersController)