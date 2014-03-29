window.Affects ||= {}
class window.Affects.ProtectiveShieldBuff
  applyTo: (creature, params) ->
    console.log 'Applying protective shield'
    @applicator = params.by
    @receiver = creature
    @name = "Щит (Защищающий удар) [#{@applicator.p.name}]"
    @type = "Щит (Защищающий удар)"
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
    creature.i.acBonus ||= 0
    creature.i.acBonus += @applicator.mod('wis')
    creature.addAffect @
    @applicator.registerEventHandler 'endOfTurn', =>
      @eot_counter -= 1
      if @eot_counter == 0
        @removeFrom(@receiver)

  removeFrom: (creature) ->
    creature.i.acBonus ||= 0
    creature.i.acBonus -= @applicator.mod('wis')
    creature.deleteAffect @
    delete @

  afterHit: ->
    console.log 'Protective shield laid'

Affects.ProtectiveShieldBuff.$inject = []

angular.module("dndApp").factory("Affects.ProtectiveShieldBuff", -> new Affects.ProtectiveShieldBuff())