class AddSkillSpinningSweep < ActiveRecord::Migration
  def change
    Skill.create(
        title: 'Круговой Взмах',
        attack_char_from: 'str',
        attack_char_to: 'ac',
        js_class: 'Skills.SpinningSweep'
    )
  end
end
