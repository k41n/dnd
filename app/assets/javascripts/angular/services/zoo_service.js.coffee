class window.Zoo
  constructor: (Monster, @$injector) ->
    @loading = Monster.query {}, (monsters) =>
      @monsters = {}
      for m in monsters
        @monsters[m.id] = new Creature(m)

Zoo.$inject = ["Monster", "$injector"]

angular.module("dndApp").service("Zoo", Zoo)