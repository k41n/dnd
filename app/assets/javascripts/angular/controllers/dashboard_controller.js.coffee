class window.DashboardController
  constructor: (@$scope, Monster, @$injector) ->
    @$scope.players = Monster.query()

DashboardController.$inject = ["$scope", "Monster", "$injector"]

angular.module("dndApp").controller("DashboardController", DashboardController)