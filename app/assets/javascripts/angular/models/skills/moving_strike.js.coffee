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
    @char.grid.markEnemyMoveableCellsForCreature @target, 2, (location) =>
      @char.grid.move(@target, location)