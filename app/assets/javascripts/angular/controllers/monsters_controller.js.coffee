class window.MonstersController
  constructor: (@$scope, Monster, @$injector) ->
    @$scope.players = Monster.query()

MonstersController.$inject = ["$scope", "Monster", "$injector"]

angular.module("dndApp").controller("MonsterController", MonstersController)