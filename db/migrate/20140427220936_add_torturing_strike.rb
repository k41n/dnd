class AddTorturingStrike < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Мучительный удар',
        attack_char_from: 'dex',
        attack_char_to: 'ac',
        js_class: 'Skills.TorturingStrike',
        cooldown_type: 'combat'
    )

  end
end
