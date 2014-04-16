window.Affects ||= {}
class window.Affects.Immobilized
  applyTo: (creature, params) ->
    @applicator = params.by
    @duration = params.duration
    @receiver = creature
    @name = "Обездвижен [#{@applicator.p.name}]"
    @type = "Обездвижен"

    @trigger('applied', {to: @receiver, by: @applicator})

  trigger: (name, params) ->
    if name == 'applied'
      @receiver = params.to
      unless @isAffectedOn(@receiver)
        @affectOn(@receiver)

  isAffectedOn: (creature) ->
    creature.affectTypes().indexOf(@type) != -1

  affectOn: (creature) ->
    creature.addAffect @

  removeFrom: (creature) ->
    creature.deleteAffect @
    delete @


Affects.Immobilized.$inject = []

angular.module("dndApp").factory("Affects.Immobilized", -> new Affects.Immobilized())