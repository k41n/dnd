window.Races ||= {}
class window.Races.Halfelf extends Races.BaseRace
  selectedFor: (char) ->
    super(char)
    char.statBonuses.con += 2
    char.statBonuses.cha += 2
    char.speed = 6
    char.abilityBonus['Переговоры'] = 2
    char.abilityBonus['Проницательность'] = 2

  deselectedFor: (char) ->
    if char?
      super(char)
      char.statBonuses.cha -= 2
      char.statBonuses.str -= 2
      char.speed = undefined
