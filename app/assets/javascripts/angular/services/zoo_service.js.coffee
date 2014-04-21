class window.Zoo
  constructor: (Monster, @$injector, @Creature) ->
    @loading = Monster.query {}, (monsters) =>
      @monsters = {}
      for m in monsters
        @monsters[m.id] = @Creature.new(m)
        @monsters[m.id].hostile = true

  getById: (id) ->
    @monsters[id]

  instance: (m) ->
    @Creature.new(m.p, m.i)

  instanceById: (id) ->
    @Creature.new(@monsters[id].p) 

Zoo.$inject = ["Monster", "$injector", 'Creature']

angular.module("dndApp").service("Zoo", Zoo)