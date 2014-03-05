window.Affects ||= {}
class window.Affects.ArmorBuff
  applyTo: (creature) ->
    @trigger('applied', {to: creature})

  trigger: (name, params) ->
    if name == 'applied'
      @applicator = params.to
      @applicator.addAffect(@)

      for c in @applicator.neighbors()
        @affectOn c  if @shouldAffectOn c

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
    creature.ac += 1
    @assigned ||= []
    @assigned.push creature

  removeFrom: (creature) ->
    creature.ac -= 1
    index = @assigned.indexOf(creature)
    @assigned.splice(index, 1)

  shouldAffectOn: (creature) ->
    @distance(@applicator.location, creature.location) < 2


Affects.ArmorBuff.$inject = []

angular.module("dndApp").factory("Affects.ArmorBuff", -> new Affects.ArmorBuff())