window.Affects ||= {}
class window.Affects.CounterstrikeDebuff
  applyTo: (creature, params) ->
    @applicator = params.by
    @receiver = creature
    @name = "Контратака (Ответный удар) [#{@applicator.p.name}]"
    @type = "Контратака (Ответный удар)"

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
    @applicator.registerEventHandler 'attackedBy', (params) =>
      if params.by == @receiver
        # Rogue was attacked by combatant with debuff
        skill = @applicator.addSkillByJsClass('Skills.CounterstrikeOnAttack')
        console.log "skill = ", skill
        skill.apply @applicator, @receiver
        @applicator.removeSkill skill

    @applicator.registerEventHandler 'start_of_turn', =>
      @removeFrom(@receiver)

  removeFrom: (creature) ->
    creature.deleteAffect @
    delete @

Affects.CounterstrikeDebuff.$inject = []

angular.module("dndApp").factory("Affects.CounterstrikeDebuff", -> new Affects.CounterstrikeDebuff())