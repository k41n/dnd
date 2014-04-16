window.Affects ||= {}
class window.Affects.Slowed
  applyTo: (creature, params) ->
    @applicator = params.by
    @duration = params.duration
    @receiver = creature
    @name = "Замедлен [#{@applicator.p.name}]"
    @type = "Замедлен"

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


Affects.Slowed.$inject = []

angular.module("dndApp").factory("Affects.Slowed", -> new Affects.Slowed())