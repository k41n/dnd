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
    console.log "ProficientStrike#pickable", @
    console.log "ProficientStrike#pickable", char
    super(char) && char.weapon? && 
      ( char.weapon.weapon_group_name == 'Легкие клинки' ||
        char.weapon.weapon_group_name == 'Арбалеты' ||
        char.weapon.weapon_group_name == 'Пращи' )

  highlightTargets: (grid, applicator) ->
    @highlightInRadius(grid,applicator, 2)
    grid.markMoveableCellsForCreature(applicator, 2) unless @moved

  onUsageStart: ->
    console.log 'Proficient strike usage start', @char
    @moveHandler = @char.registerEventHandler 'move', =>
      console.log 'Applicator of proficient strike moved'
      @moved = true
    @char.registerEventHandler 'endOfTurn', =>
      @moved = false
      @char.unregisterEventHandler 'move', @moveHandler

    console.log 'Proficient strike usage start finished', @char

  saveToJSON: ->
    ret = super()
    ret.moved = @moved
    ret

  loadFromJSON: (json) ->
    console.log "ProficientStrike#loadFromJSON", json
    super(json)
    @moved = json.moved
