#= require './base_perk'

window.Perks ||= {}
class window.Perks.RogueTactics extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.character_class && character.character_class.name == 'Плут'

  autoPickable: ->
    true

  configurable: ->
    true

  dialogClass: ->
    'RogueTacticsDialog'

  dialogTemplate: ->
    '/rogue_tactics_dialog.html'

  configure: (params) ->
    @stat = params.stat

  configuration: ->
    stat: @stat

  desc: ->
    if @stat?
      @stat
    else
      ''
