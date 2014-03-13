class RewriteSkillAssigments < ActiveRecord::Migration
  def up
    remove_column :skill_assignments, :owner_id
    add_column :skill_assignments, :owner_id, :integer
  end

  def down
    remove_column :skill_assignments, :owner_id
    add_column :skill_assignments, :owner_id, :string
  end
end
