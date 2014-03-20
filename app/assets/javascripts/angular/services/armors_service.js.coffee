class window.Armors
  constructor: (Armor) ->
    @loading = Armor.query {}, (data) =>
      @armors = {}
      @shields = {}
      for armor in data
        if armor.armor_type == 'Shield'
          @shields[armor.id] = armor
        else
          @armors[armor.id] = armor

  create: (id) ->
    armor = @armors[id]
    if armor?
      return new (eval(armor.js_class))(armor)

  create_shield: (id) ->
    shield = @shields[id]
    if shield?
      return new (eval(shield.js_class))(shield)

Armors.$inject = ["Armor"]

angular.module("dndApp").service("Armors", Armors)