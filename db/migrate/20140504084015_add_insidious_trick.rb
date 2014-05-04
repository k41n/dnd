class AddInsidiousTrick < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Коварный финт',
        attack_char_from: 'dex',
        attack_char_to: 'ac',
        js_class: 'Skills.InsidiousTrick',
        cooldown_type: 'unlimited'
    )
  end
end
