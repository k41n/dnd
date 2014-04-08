#= require './base_perk'

window.Perks ||= {}
class window.Perks.WeaponFocus extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  autoPickable: ->
    false

  configurable: ->
    true

  dialogClass: ->
    'WeaponFocusDialog'

  dialogTemplate: ->
    '/weapon_focus_dialog.html'

  configure: (params) ->
    @weapon_group = params.weapon_group

  configuration: ->
    weapon_group: @weapon_group

  desc: ->
    if @weapon_group
      "+1 урон #{@weapon_group}"
    else
      ''

  damageBonus: (character) ->
    @char ||= character
    return 0 unless @char?
    return 0 unless @char.weapon?
    return 0 unless @char.weapon.weapon_group_name?
    return 0 unless @weapon_group
    if @char.weapon.weapon_group_name == @weapon_group
      return 1
    else
      return 0
