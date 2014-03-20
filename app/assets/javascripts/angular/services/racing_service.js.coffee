class window.Racing
  constructor: (Race, @$injector) ->
    @races = {}
    races = Race.query {},  =>
      for race in races
        @races[race.id] = race

  create: (id) ->
    race = @races[id]
    if race? && race.js_class? && eval(race.js_class)?
      return new (eval(race.js_class))(race)
    else
      return new Races.BaseRace(race)

Racing.$inject = ["Race", "$injector"]

angular.module("dndApp").service("Racing", Racing)