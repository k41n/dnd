window.Skills ||= {}
class window.Skills.ProficientStrike extends Skills.BaseAttack
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
    char.mod('dex') + char.damageBonus()

  pickable: (char) ->
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки' ||
        char.weapon.weapon_group_name == 'Арбалеты' ||
        char.weapon.weapon_group_name == 'Пращи' )

  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)
    grid.markMoveableCellsForCreature(applicator, 2) unless @moved

  onUsageStart: ->
    @moveHandler = @char.registerEventHandler 'move', =>
      @moved = true
    @char.registerEventHandler 'endOfTurn', =>
      @moved = false
      @char.unregisterEventHandler 'move', @moveHandler

  saveToJSON: ->
    ret = super()
    ret.moved = @moved
    ret

  loadFromJSON: (json) ->
    super(json)
    @moved = json.moved
    @onUsageStart() if @moved && @char?
