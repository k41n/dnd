window.Affects ||= {}
class window.Affects.RighteousJudgementBuff
  applyTo: (creature, params) ->
    @applicator = params.by
    @receiver = creature
    @name = "Временные хиты (Праведная кара) [#{@applicator.p.name}]"
    @type = "Временные хиты (Праведная кара)"

    @trigger('applied', {to: @receiver, by: @applicator})

  trigger: (name, params) ->
    if name == 'applied'
      @receiver = params.by
      for c in @applicator.neighbors(6)
        @affectOn c unless @isAffectedOn c
      unless @isAffectedOn(@receiver)
        @affectOn(@receiver) unless @isAffectedOn @receiver

  isAffectedOn: (creature) ->
    creature.affectTypes().indexOf(@type) != -1

  affectOn: (creature) ->
    console.log 'Affecting ', creature
    creature.i.tempHp ||= 0
    creature.i.tempHp += @applicator.mod('wis') + 5
    creature.addAffect @

Affects.RighteousJudgementBuff.$inject = []

angular.module("dndApp").factory("Affects.RighteousJudgementBuff", -> new Affects.RighteousJudgementBuff())