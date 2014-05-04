class AddAstoundingBlow < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Изумляющий удар',
        attack_char_from: 'dex',
        attack_char_to: 'ac',
        js_class: 'Skills.AstoundingBlow',
        cooldown_type: 'combat'
    )
  end
end
