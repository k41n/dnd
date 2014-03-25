class AddSkillReapingStrike < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Косящий Удар',
        attack_char_from: 'str',
        attack_char_to: 'ac',
        js_class: 'Skills.ReapingStrike'
    )
  end
end
