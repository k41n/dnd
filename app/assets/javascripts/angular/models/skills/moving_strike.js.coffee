window.Skills ||= {}
class window.Skills.MovingStrike extends Skills.BaseAttack
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
    char.mod('dex') + char.damageBonus()

  pickable: (char) ->
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки' )

  afterHit: ->
    super()
    distance = 1
    rogueTactics = @char.findPerkByJsClass('Perks.RogueTactics')
    if rogueTactics? && rogueTactics.stat == 'Мастер уклонения'
      distance += @char.mod('cha')

    @char.grid.markEnemyMoveableCellsForCreature @target, distance, (location) =>
      @char.grid.move(@target, location)