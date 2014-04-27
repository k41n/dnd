class AddProficientStrike < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Искусный удар',
        attack_char_from: 'dex',
        attack_char_to: 'ac',
        js_class: 'Skills.ProficientStrike'
    )
  end
end
