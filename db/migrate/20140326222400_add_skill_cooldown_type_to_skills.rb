class AddSkillCooldownTypeToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :cooldown_type, :string
  end
end
