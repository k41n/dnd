class AddMovingStrike < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Перемещающий удар',
        attack_char_from: 'dex',
        attack_char_to: 'will',
        js_class: 'Skills.MovingStrike',
        cooldown_type: 'combat'
    )
  end
end
