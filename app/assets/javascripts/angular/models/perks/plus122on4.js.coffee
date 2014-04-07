#= require './base_perk'

window.Perks ||= {}
class window.Perks.Plus122on4 extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.p.level >= 4

  autoPickable: ->
    true

  configurable: ->
    true

  dialogClass: ->
    'Plus122On4Dialog'

  dialogTemplate: ->
    '/plus_122_on_4_dialog.html'

  getBonus: (stat) ->
    if @stat1? && stat == @stat1
      return 1
    if @stat2? && stat == @stat2
      return 1
    0

  desc: ->
    if @stat1? && @stat2
      "#{@stat1}+1, #{@stat2}+1"
    else
      ''

  configure: (params) ->
    @onRemoved(@char)
    @stat1 = params.stat1
    @stat2 = params.stat2
    @onPicked(@char)    

