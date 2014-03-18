class AddLevelAndStatPointsToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :xp, default: 0
      t.integer :level, default: 1
      t.integer :stat_points, default: 22
    end
  end
end
