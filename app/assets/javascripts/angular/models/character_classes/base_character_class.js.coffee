window.CharacterClasses ||= {}
class window.CharacterClasses.BaseCharacterClass
  constructor: (factory_params) ->
    if factory_params
      for k,v of factory_params
        @[k] = v

  classTrainingsCount: ->
    0

  healsCount: ->
    0

  calculateHP: ->
    '-'

  forcedTrainings: ->
    []

  reactionBonus: ->
    0