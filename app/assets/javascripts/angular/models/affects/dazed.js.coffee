window.Affects ||= {}
class window.Affects.Dazed
  applyTo: (creature, params) ->
    @applicator = params.by
    @eot_counter = params.duration
    @receiver = creature
    @name = "Изумлен [#{@applicator.p.name}]"
    @type = "Изумлен"
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
    @applicator.registerEventHandler 'endOfTurn', =>
      @eot_counter -= 1
      if @eot_counter == 0
        @removeFrom(@receiver)

  removeFrom: (creature) ->
    creature.deleteAffect @
    delete @

  givesCombatSuperiorityTo: (enemy) ->
    true


Affects.DazedDebugg.$inject = []

angular.module("dndApp").factory("Affects.Dazed", -> new Affects.Dazed())