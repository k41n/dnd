window.Perks ||= {}
class window.Perks.BasePerk
  constructor: (data) ->
    for key,val of data
      @[key] = val

  pickable: (character) ->
    !character.hasPerk(@)

  autoPickable: ->
    false

  onPicked: (character) ->
    @char = character

  onRemoved: (character) ->
    @char = null

  getBonus: (stat) ->
    @["#{stat}Bonus"] || 0

  configurable: ->
    false

  dialogClass: ->
    1

  dialogTemplate: ->
    1

  desc: ->
    @description || ''

  configure: (settings) ->
    true

  configuration: ->
    {}

  damageBonus: ->
    0

  toHitBonus: ->
    0
