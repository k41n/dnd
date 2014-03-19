class AddColumnTextToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :text, :text
  end
end
