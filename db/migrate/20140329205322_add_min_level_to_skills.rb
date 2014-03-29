class AddMinLevelToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :min_level, :integer, default: 1
  end
end
