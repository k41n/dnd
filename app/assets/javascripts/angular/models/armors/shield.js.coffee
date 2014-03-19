window.Armors ||= {}
class window.Armors.Shield
  constructor: (data) ->
    for key,val of data
      @[key] = val