class AddParamsToMonster < ActiveRecord::Migration
  def change
    change_table :monsters do |t|
      t.string :role
      t.string :monster_type
      t.integer :level
      t.integer :xp
      t.string :size
      t.integer :hp
      t.integer :initiative
      t.integer :ac
      t.integer :endurance
      t.integer :reaction
      t.integer :will
      t.integer :save_rolls
      t.integer :speed
      t.integer :action_points
    end
  end
end
