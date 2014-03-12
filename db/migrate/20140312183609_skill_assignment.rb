class SkillAssignment < ActiveRecord::Migration
  def change
    create_table :skill_assignments do |t|
      t.string :owner_type
      t.string :owner_id
      t.references :skill
    end
    add_index :skill_assignments, :owner_id

    remove_columns :skills, :owner_type, :owner_id
  end
end
