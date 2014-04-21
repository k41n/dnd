window.Skills ||= {}
class window.Skills.CounterstrikeOnAttack extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  damage: (char) ->
    char ||= @char
    char.getWeaponDamage() + '+' + @damageBonus()

  toHitBonus: (char) ->
    char ||= @char
    super(char)

  damageRollCount: (char) ->
    char ||= @char
    char.weapon.damage_count

  damageRollDice: (char) ->
    char ||= @char
    char.weapon.damage_dice

  damageBonus: (char) ->
    char ||= @char
    char.mod('str') + char.damageBonus()
