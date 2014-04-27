class window.Weapons
  constructor: (Weapon) ->
    @loading = Weapon.query {}, (data) =>
      console.log "Loaded weapons", data
      @weapons = {}      
      for weapon in data
        @weapons[weapon.id] = weapon

  create: (id) ->
    weapon = @weapons[id]
    if weapon? && weapon.js_class? && eval(weapon.js_class)?
      return new (eval(weapon.js_class))(weapon)
    else
      return new Weapons.BaseWeapon(weapon)

Weapons.$inject = ["Weapon"]

angular.module("dndApp").service("Weapons", Weapons)