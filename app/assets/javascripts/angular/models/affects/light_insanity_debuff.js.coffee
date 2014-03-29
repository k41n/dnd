window.Affects ||= {}
class window.Affects.LightInsanityDebuff
  applyTo: (creature, params) ->
    @applicator = params.by
    @receiver = creature
    @name = "Изумлен (Световое помешательство) [#{@applicator.p.name}]"
    @type = "Изумлен (Световое помешательство)"
    @eot_counter = 2
    @keepAc = params.keepAc || false

    @trigger('applied', {to: @receiver, by: @applicator})

  trigger: (name, params) ->
    if name == 'applied'
      @receiver = params.to
      unless @isAffectedOn(@receiver)
        @affectOn(@receiver)

  isAffectedOn: (creature) ->
    creature.affectTypes().indexOf(@type) != -1

  affectOn: (creature) ->
    creature.i.acBonus ||= 0
    unless @keepAc
      creature.i.acBonus -= 2
    creature.addAffect @
    @applicator.registerEventHandler 'endOfTurn', =>
      @eot_counter -= 1
      if @eot_counter == 0
        @removeFrom(@receiver)

  removeFrom: (creature) ->
    creature.i.acBonus ||= 0
    unless @keepAc
      creature.i.acBonus += 2
    creature.deleteAffect @
    delete @


Affects.LightInsanityDebuff.$inject = []

angular.module("dndApp").factory("Affects.LightInsanityDebuff", -> new Affects.LightInsanityDebuff())