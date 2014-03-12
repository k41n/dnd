class AddTimestampsToSkills < ActiveRecord::Migration
  def change
    change_table :skills do |t|
      t.timestamps
    end
  end
end
