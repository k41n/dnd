window.Races ||= {}
class window.Races.Teephling extends Races.BaseRace
  statBonus: (stat) ->
    if stat == 'cha' || stat == 'int'
      2
    else 
      0

  getSpeed: ->
    6


  # selectedFor: (char) ->
  #   super(char)
  #   char.statBonuses.int += 2
  #   char.statBonuses.cha += 2
  #   char.speed = 6
  #   char.abilityBonus['Обман'] = 2
  #   char.abilityBonus['Скрытность'] = 2

  # deselectedFor: (char) ->
  #   if char?
  #     super(char)
  #     char.statBonuses.cha -= 2
  #     char.statBonuses.str -= 2
  #     char.speed = undefined
