class window.Zoo
  constructor: (Monster, @$injector) ->
    @monsters = Monster.query()

Zoo.$inject = ["Monster", "$injector"]

angular.module("dndApp").service("Zoo", Zoo)