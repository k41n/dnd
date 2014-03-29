window.Races ||= {}
class window.Races.Dragonborn extends Races.BaseRace
  selectedFor: (char) ->
    super(char)
    char.statBonuses.cha += 2
    char.statBonuses.str += 2
    char.speed = 6
    char.abilityBonus['Запугивание'] = 2
    char.abilityBonus['История'] = 2

  deselectedFor: (char) ->
    super(char)
    if char?
      super(char)
      char.statBonuses.cha -= 2
      char.statBonuses.str -= 2
      char.speed = undefined
