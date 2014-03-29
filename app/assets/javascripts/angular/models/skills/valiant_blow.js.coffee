window.Skills ||= {}
class window.Skills.ValiantBlow extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  damage: (char) ->
    char ||= @char
    char.getWeaponDamage() + '+' + char.mod('str')

  toHitBonus: (char) ->
    char ||= @char
    base = super(char)
    base + char.hostileNeighbours().length

  damageRollCount: (char) ->
    char ||= @char
    char.weapon.damage_count

  damageRollDice: (char) ->
    char ||= @char
    char.weapon.damage_dice

  damageBonus: (char) ->
    char ||= @char
    char.mod('str')
