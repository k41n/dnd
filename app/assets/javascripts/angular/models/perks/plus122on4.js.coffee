#= require './base_perk'

window.Perks ||= {}
class window.Perks.Plus122on4 extends Perks.BasePerk
  constructor: (data) ->
    super(data)

  pickable: (character) ->
    console.log "character.p.level", character.p.level
    character.p.level >= 4

  autoPickable: ->
    true

  onPicked: (character) ->
    super(character)
    if @stat1 && @stat2?
      character.i["#{@stat1}_bonus"] ||= 0
      character.i["#{@stat1}_bonus"] += 1
      character.i["#{@stat2}_bonus"] ||= 0
      character.i["#{@stat2}_bonus"] += 1

  onRemoved: (character) ->
    if @stat1 && @stat2?
      character.i["#{@stat1}_bonus"] ||= 0
      character.i["#{@stat1}_bonus"] -= 1
      character.i["#{@stat2}_bonus"] ||= 0
      character.i["#{@stat2}_bonus"] -= 1

  configurable: ->
    true

  dialogClass: ->
    'Plus122On4Dialog'

  dialogTemplate: ->
    '/plus_122_on_4_dialog.html'

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

