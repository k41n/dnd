class window.Perks
  constructor: (@Perk) ->
    @loading = @Perk.query {}, (data) =>
      @perks = {}
      for perk in data
        @perks[perk.id] = @create(perk)

  create: (data) ->
    if data? && data.js_class? && eval(data.js_class)?
      new (eval(data.js_class))(data)
    else
      new Perks.BasePerk(data)

  getById: (id) ->
    @create(@perks[id])

Perks.$inject = ["Perk"]

angular.module("dndApp").service("Perks", Perks)