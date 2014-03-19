class window.Weapons
  constructor: (Weapon) ->
    @loading = Weapon.query {}, (data) =>
      @weapons = {}      
      for weapon in data
        @weapons[weapon.id] = weapon

  create: (id) ->
    weapon = @weapons[id]
    if weapon?
      return new (eval(weapon.js_class))(weapon)

Weapons.$inject = ["Weapon"]

angular.module("dndApp").service("Weapons", Weapons)