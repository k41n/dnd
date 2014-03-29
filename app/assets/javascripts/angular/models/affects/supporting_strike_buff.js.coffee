window.Affects ||= {}
class window.Affects.SupportingStrikeBuff
  applyTo: (creature, params) ->
    @applicator = params.by
    @receiver = creature
    @name = "Временные хиты (Поддерживающий удар) [#{@applicator.p.name}]"
    @type = "Временные хиты (Поддерживающий удар)"

    @trigger('applied', {to: @receiver, by: @applicator})

  trigger: (name, params) ->
    if name == 'applied'
      @receiver = params.by
      unless @isAffectedOn(@receiver)
        @affectOn(@receiver)

  isAffectedOn: (creature) ->
    creature.affectTypes().indexOf(@type) != -1

  affectOn: (creature) ->
    console.log 'Affecting ', creature
    creature.i.tempHp ||= 0
    creature.i.tempHp += creature.mod('wis')
    creature.addAffect @

Affects.SupportingStrikeBuff.$inject = []

angular.module("dndApp").factory("Affects.SupportingStrikeBuff", -> new Affects.SupportingStrikeBuff())