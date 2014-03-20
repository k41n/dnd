window.Races ||= {}
class window.Races.BaseRace
  constructor: (factory_params) ->
    if factory_params
      for k,v of factory_params
        @[k] = v
  
  selectedFor: (char) ->
    char.statBonuses ||= {}
    char.statBonuses.con ||= 0
    char.statBonuses.str ||= 0
    char.statBonuses.cha ||= 0
    char.statBonuses.dex ||= 0
    char.statBonuses.wis ||= 0
    char.statBonuses.int ||= 0
    char.abilityBonus ||= {}

  deselectedFor: (char) ->
    if char?
      console.log 'Deselected ', @
      char.statBonus = {}
      char.abilityBonus = {}
      char.statBonuses.con ||= 0
      char.statBonuses.str ||= 0
      char.statBonuses.cha ||= 0
      char.statBonuses.dex ||= 0
      char.statBonuses.wis ||= 0
      char.statBonuses.int ||= 0
