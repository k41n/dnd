class AddCounterstrikeOnAttackSkill < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Ответный удар (реакция)',
        attack_char_from: 'str',
        attack_char_to: 'ac',
        js_class: 'Skills.CounterstrikeOnAttack'
    )
  end
end
