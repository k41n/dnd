#= require './base_perk'

window.Perks ||= {}
class window.Perks.HumanFlexibility extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    character.race? && character.race.name == 'Человек'

  autoPickable: ->
    true


  onPicked: (character) ->
    console.log "Applying perk", @
    super(character)
    if @stat?
      console.log 'Stat found, applying perk', character
      character.i["#{@stat}_bonus"] ||= 0
      character.i["#{@stat}_bonus"] += 2
      console.log 'Stat found, applied perk', character

  onRemoved: (character) ->
    if @stat?
      character.i["#{@stat}_bonus"] ||= 0
      character.i["#{@stat}_bonus"] -= 2

  configurable: ->
    true

  dialogClass: ->
    'HumanFlexibilityDialog'

  dialogTemplate: ->
    '/human_flexibility_dialog.html'

  desc: ->
    if @stat?
      "#{@stat} +2"
    else
      ''

  configure: (params) ->
    @onRemoved(@char)
    @stat = params.stat
    @onPicked(@char)    

