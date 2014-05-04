window.Affects ||= {}
class window.Affects.BaseAffect
  getAcBonus: ->
    @acBonus || 0

  givesCombatSuperiorityTo: (to) ->
    false