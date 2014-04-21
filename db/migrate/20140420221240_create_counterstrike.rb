class CreateCounterstrike < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Ответный удар',
        attack_char_from: 'dex',
        attack_char_to: 'ac',
        js_class: 'Skills.Counterstrike'
    )
  end
end
