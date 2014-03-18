class window.Chars
  constructor: (@Character, @$injector, @$http) ->
    @loading = @Character.query {}, (data) =>
      @characters = {}
      for c in data
        @characters[c.id] = c

  inviteByName: (name, toGame) ->
    c = new @Character()
    c.$invite {gameId: toGame.id, name: name}

  uninviteByName: (name, toGame) ->
    c = new @Character()
    c.$uninvite {gameId: toGame.id, name: name}

  kickByName: (name, fromGame) ->
    c = new @Character()
    c.$kick {gameId: fromGame.id, name: name}

  findByName: (name) ->
    for id, char of @characters
      return char if char.name == name
    return null

  names: ->
    ret = []
    for id, char of @characters
      ret.push char.name
    ret

Chars.$inject = ["Character", "$injector"]

angular.module("dndApp").service("Chars", Chars)