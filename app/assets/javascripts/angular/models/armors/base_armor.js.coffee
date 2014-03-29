window.Armors ||= {}
class window.Armors.BaseArmor
  constructor: (data) ->
    for key,val of data
      @[key] = val