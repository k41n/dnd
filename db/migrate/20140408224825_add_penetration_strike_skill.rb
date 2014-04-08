class AddPenetrationStrikeSkill < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Пронзающий удар',
        attack_char_from: 'dex',
        attack_char_to: 'reaction',
        js_class: 'Skills.PenetrationStrike'
    )

  end
end
