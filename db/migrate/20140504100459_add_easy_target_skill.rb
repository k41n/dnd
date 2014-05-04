class AddEasyTargetSkill < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Легкая цель',
        attack_char_from: 'dex',
        attack_char_to: 'ac',
        js_class: 'Skills.EasyTarget',
        cooldown_type: 'day'
    )
  end
end
