class window.Racing
  constructor: (Race, @$injector) ->
    @races = {}
    races = Race.query {},  =>
      for race in races
        @races[race.id] = race

  create: (id) ->
    race = @races[id]
    if race?
      return new (eval(race.js_class))(race)

Racing.$inject = ["Race", "$injector"]

angular.module("dndApp").service("Racing", Racing)