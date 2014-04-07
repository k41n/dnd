#= require './base_perk'

window.Perks ||= {}
class window.Perks.HumanFlexibility extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.race? && character.race.name == 'Человек'

  autoPickable: ->
    true

  configurable: ->
    true

  dialogClass: ->
    'HumanFlexibilityDialog'

  dialogTemplate: ->
    '/human_flexibility_dialog.html'

  getBonus: (stat) ->
    if @stat? && stat == @stat
      2
    else 
      0

  desc: ->
    if @stat?
      "#{@stat} +2"
    else
      ''

  configure: (params) ->
    @onRemoved(@char)
    @stat = params.stat
    @onPicked(@char)    

