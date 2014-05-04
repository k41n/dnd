window.fixtures ||= {}

window.fixtures.valiant_blow = {
  name: 'Доблестный удар'
  available_for: [1]
  js_class: 'Skills.ValiantBlow'
  cooldown_type: 'unlimited'
  id: 1
  attack_char_from: 'str'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.weakening_strike = {
  name: 'Ослабляющий удар'
  available_for: [1]
  js_class: 'Skills.WeakeningStrike'
  cooldown_type: 'unlimited'
  id: 2
  attack_char_from: 'cha'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.protecting_strike = {
  name: 'Защищающий удар'
  available_for: [1]
  js_class: 'Skills.ProtectingStrike'
  cooldown_type: 'unlimited'
  id: 3
  attack_char_from: 'cha'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.protective_shield = {
  name: 'Паладинский Щит'
  available_for: [1]
  js_class: 'Skills.ProtectiveShield'
  cooldown_type: 'unlimited'
  id: 4
  attack_char_from: 'cha'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.righteous_judgement = {
  name: 'Праведная кара'
  available_for: [1]
  js_class: 'Skills.RighteousJudgement'
  cooldown_type: 'unlimited'
  id: 5
  attack_char_from: 'cha'
  attack_char_to: 'ac'
  min_level: 3
}

window.fixtures.light_insanity = {
  name: 'Световое помешательство'
  available_for: [1]
  js_class: 'Skills.LightInsanity'
  cooldown_type: 'day'
  id: 6
  attack_char_from: 'cha'
  attack_char_to: 'reaction'
  min_level: 1
}

window.fixtures.sacred_circle = {
  name: 'Освященный круг'
  available_for: [1]
  js_class: 'Skills.SacredCircle'
  cooldown_type: 'day'
  id: 7
  attack_char_from: 'cha'
  attack_char_to: 'reaction'
  min_level: 5
}

window.fixtures.penetration_strike = {
  name: 'Пронзающий удар'
  available_for: [2]
  js_class: 'Skills.PenetrationStrike'
  cooldown_type: 'unlimited'
  id: 8
  attack_char_from: 'dex'
  attack_char_to: 'reaction'
  min_level: 1
}

window.fixtures.counterstrike = {
  name: 'Ответный удар'
  available_for: [2]
  js_class: 'Skills.Counterstrike'
  cooldown_type: 'unlimited'
  id: 9
  attack_char_from: 'dex'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.counterstrike_on_attack = {
  name: 'Ответный удар (реакция)'
  available_for: [2]
  js_class: 'Skills.CounterstrikeOnAttack'
  cooldown_type: 'unlimited'
  id: 10
  attack_char_from: 'str'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.proficient_strike = {
  name: 'Искусный удар'
  available_for: [2]
  js_class: 'Skills.ProficientStrike'
  cooldown_type: 'unlimited'
  id: 11
  attack_char_from: 'dex'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.torturing_strike = {
  name: 'Мучительный удар'
  available_for: [2]
  js_class: 'Skills.TorturingStrike'
  cooldown_type: 'combat'
  id: 12
  attack_char_from: 'dex'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.moving_strike = {
  name: 'Перемещающий удар'
  available_for: [2]
  js_class: 'Skills.MovingStrike'
  cooldown_type: 'combat'
  id: 13
  attack_char_from: 'dex'
  attack_char_to: 'will'
  min_level: 1
}

window.fixtures.insidious_trick = {
  name: 'Коварный финт'
  available_for: [2]
  js_class: 'Skills.InsidiousTrick'
  cooldown_type: 'unlimited'
  id: 14
  attack_char_from: 'dex'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.astounding_blow = {
  name: 'Изумляющий удар'
  available_for: [2]
  js_class: 'Skills.AstoundingBlow'
  cooldown_type: 'combat'
  id: 15
  attack_char_from: 'dex'
  attack_char_to: 'ac'
  min_level: 1
}

window.fixtures.easy_target = {
  name: 'Легкая цель'
  available_for: [2]
  js_class: 'Skills.EasyTarget'
  cooldown_type: 'day'
  id: 16
  attack_char_from: 'dex'
  attack_char_to: 'ac'
  min_level: 1
}
