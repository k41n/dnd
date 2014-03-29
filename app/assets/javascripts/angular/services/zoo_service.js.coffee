class window.Zoo
  constructor: (Monster, @$injector, @Creature) ->
    @loading = Monster.query {}, (monsters) =>
      @monsters = {}
      for m in monsters
        @monsters[m.id] = @Creature.new(m)
        @monsters[m.id].hostile = true


  getById: (id) ->
    @monsters[id]

Zoo.$inject = ["Monster", "$injector", 'Creature']

angular.module("dndApp").service("Zoo", Zoo)