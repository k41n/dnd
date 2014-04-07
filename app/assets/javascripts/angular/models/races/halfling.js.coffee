window.Races ||= {}
class window.Races.Halfling extends Races.BaseRace
  statBonus: (stat) ->
    if stat == 'cha' || stat == 'dex'
      2
    else 
      0

  getSpeed: ->
    6
  #   char.statBonuses.cha += 2
  #   char.statBonuses.dex += 2
  #   char.speed = 6
  #   char.abilityBonus['Акробатика'] = 2
  #   char.abilityBonus['Воровство'] = 2

  # deselectedFor: (char) ->
  #   if char?
  #     super(char)
  #     char.statBonuses.cha -= 2
  #     char.statBonuses.str -= 2
  #     char.speed = undefined
