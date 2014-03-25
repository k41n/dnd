window.Perks ||= {}
class window.Perks.BasePerk
  constructor: (data) ->
    for key,val of data
      @[key] = val

  pickable: (character) ->
    false