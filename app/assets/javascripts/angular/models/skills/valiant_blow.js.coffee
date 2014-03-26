window.Skills ||= {}
class window.Skills.ValiantBlow extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  toHitBonus: (char) ->
    Math.floor(char.level / 2.0) + char.mod(@attack_char_from) + '+1 every enemy near'

  damage: (char) ->
    char.getWeaponDamage() + '+' + char.mod('str')

