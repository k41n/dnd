window.Armors ||= {}
class window.Armors.Cloth
  constructor: (data) ->
    for key,val of data
      @[key] = val