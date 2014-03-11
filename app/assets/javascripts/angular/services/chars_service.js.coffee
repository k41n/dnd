class window.Chars
  constructor: (Character, @$injector) ->
    @characters = Character.query()

Chars.$inject = ["Character", "$injector"]

angular.module("dndApp").service("Chars", Chars)