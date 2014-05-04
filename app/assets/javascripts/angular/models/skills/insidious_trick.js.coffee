window.Skills ||= {}
class window.Skills.InsidiousTrick extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  damage: (char) ->
    char ||= @char
    "#{@weapon.damage_count}d#{@weapon.damage_dice}+#{@damageBonus()}"

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
    char.mod('dex') + char.mod('cha') + char.damageBonus()

  pickable: (char) ->
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки' ||
        char.weapon.weapon_group_name == 'Арбалеты' ||
        char.weapon.weapon_group_name == 'Пращи' )
