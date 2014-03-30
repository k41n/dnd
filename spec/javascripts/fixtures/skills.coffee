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