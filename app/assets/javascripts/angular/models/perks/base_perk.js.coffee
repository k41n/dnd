window.Perks ||= {}
class window.Perks.BasePerk
  constructor: (data) ->
    for key,val of data
      @[key] = val

  pickable: (character) ->
    false

  autoPickable: ->
    false

  onPicked: (character) ->
    @char = character

  onRemoved: (character) ->
    @char = null

  configurable: ->
    false

  dialogClass: ->
    1

  dialogTemplate: ->
    1

  desc: ->
    @description || ''