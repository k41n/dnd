window.Affects ||= {}
class window.Affects.Knockback
  applyTo: (creature, params) ->
    console.log 'SBIT S NOG'
    @applicator = params.by
    @receiver = creature
    @name = "Сбит с ног (Круговой взмах) [#{@applicator.p.name}]"
    @type = "Сбит с ног"

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


Affects.Knockback.$inject = []

angular.module("dndApp").factory("Affects.Knockback", -> new Affects.Knockback())