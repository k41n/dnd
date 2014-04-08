window.Races ||= {}
class window.Races.Eladrin extends Races.BaseRace
  statBonus: (stat) ->
    if stat == 'dex' || stat == 'int'
      2
    else 
      0

  getSpeed: ->
    6

  # selectedFor: (char) ->
  #   super(char)
  #   char.statBonuses.dex += 2
  #   char.statBonuses.int += 2
  #   char.willBonus += 1
  #   char.speed = 6
  #   char.abilityBonus['История'] = 2
  #   char.abilityBonus['Магия'] = 2

  # deselectedFor: (char) ->
  #   if char?
  #     super(char)
  #     char.statBonuses.dex -= 2
  #     char.statBonuses.int -= 2
  #     char.willBonus -= 1
  #     char.speed = undefined
