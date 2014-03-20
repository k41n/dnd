window.Armors ||= {}
class window.Armors.Chainmail
  constructor: (data) ->
    for key,val of data
      @[key] = val