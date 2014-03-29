window.Affects ||= {}
class window.Affects.WeakeningStrikeDebuff
  applyTo: (creature, params) ->
    @applicator = params.by
    @receiver = creature
    @name = "Ослаблен (Ослабляющий удар) [#{@applicator.p.name}]"
    @type = "Ослаблен (Ослабляющий удар)"
    @eot_counter = 2

    @trigger('applied', {to: @receiver, by: @applicator})

  trigger: (name, params) ->
    if name == 'applied'
      @receiver = params.to
      unless @isAffectedOn(@receiver)
        @affectOn(@receiver)

  isAffectedOn: (creature) ->
    creature.affectTypes().indexOf(@type) != -1

  affectOn: (creature) ->
    creature.i.toHitBonus ||= 0
    creature.i.toHitBonus -= 2
    creature.addAffect @
    @applicator.registerEventHandler 'endOfTurn', =>
      @eot_counter -= 1
      if @eot_counter == 0
        @removeFrom(@receiver)

  removeFrom: (creature) ->
    creature.i.toHitBonus ||= 0
    creature.i.toHitBonus += 2
    creature.deleteAffect @
    delete @


Affects.WeakeningStrikeDebuff.$inject = []

angular.module("dndApp").factory("Affects.WeakeningStrikeDebuff", -> new Affects.WeakeningStrikeDebuff())