window.Affects ||= {}
class window.Affects.SacredCircleBuff
  applyTo: (creature) ->
    @trigger('applied', {to: creature})

  trigger: (name, params) ->
    if name == 'applied'
      @applicator = params.to
      @center = @applicator.location
      @applicator.addAffect(@)

      console.log '@applicator.neighbors(4)', @applicator.neighbors(4)
      for c in @applicator.neighbors(4)
        @affectOn c if @shouldAffectOn c

      @affectOn @applicator if @shouldAffectOn @applicator

      # Register callback so when someone approaches, he receives buff
      @applicator.registerEventHandler 'move', (params) =>
        who_moved = params.moved
        if @shouldAffectOn who_moved
          @affectOn who_moved unless @isAffectedOn who_moved
        else
          @removeFrom who_moved if @isAffectedOn who_moved

  # FIXME: gonna be used everywhere, special class for math calcs?
  distance: (p1, p2) ->
    dx = p1.x-p2.x
    dy = p1.y-p2.y
    Math.sqrt( dx*dx+dy*dy )

  isAffectedOn: (creature) ->
    @assigned? and @assigned.indexOf(creature) != -1

  affectOn: (creature) ->
    console.log 'Affecting on ', creature
    creature.i.acBonus ||= 0
    creature.i.acBonus += 1
    creature.i.reactionBonus ||= 0
    creature.i.reactionBonus += 1
    creature.i.willBonus ||= 0
    creature.i.willBonus += 1
    creature.i.staminaBonus ||= 0
    creature.i.staminaBonus += 1
    @assigned ||= []
    @assigned.push creature

  removeFrom: (creature) ->
    creature.i.acBonus -= 1
    creature.i.reactionBonus -= 1
    creature.i.willBonus -= 1
    creature.i.staminaBonus -= 1
    index = @assigned.indexOf(creature)
    @assigned.splice(index, 1)

  shouldAffectOn: (creature) ->
    @distance(@center, creature.location) < 4 && !creature.hostile

Affects.SacredCircleBuff.$inject = []

angular.module("dndApp").factory("Affects.SacredCircleBuff", -> new Affects.SacredCircleBuff())