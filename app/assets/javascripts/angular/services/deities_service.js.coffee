class window.Deities
  constructor: (@Deity) ->
    @loading = @Deity.query {}, (data) =>
      @deities = {}
      for deity in data
        @deities[deity.id] = deity

Deities.$inject = ["Deity"]

angular.module("dndApp").service("Deities", Deities)