window.Weapons ||= {}
class window.Weapons.BaseWeapon
  constructor: (data) ->
    for key,val of data
      @[key] = val