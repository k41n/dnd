window.Skills ||= {}
class window.Skills.TorturingStrike extends Skills.BaseAttack
  constructor: (factory_params) ->
    super(factory_params)

  damage: (char) ->
    char ||= @char
    "#{2 * @weapon.damage_count}d#{@weapon.damage_dice}+#{@damageBonus()}"

  toHitBonus: (char) ->
    char ||= @char
    super(char)

  damageRollCount: (char) ->
    char ||= @char
    2 * char.weapon.damage_count

  damageRollDice: (char) ->
    char ||= @char
    char.weapon.damage_dice

  damageBonus: (char) ->
    char ||= @char
    ret = char.mod('dex') + char.damageBonus()
    rogueTactics = char.findPerkByJsClass('Perks.RogueTactics')
    if rogueTactics? && rogueTactics.stat == 'Жестокий головорез'
      ret += char.mod('str')
    ret

  pickable: (char) ->
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки' )

