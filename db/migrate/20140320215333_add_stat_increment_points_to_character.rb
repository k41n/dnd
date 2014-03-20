class AddStatIncrementPointsToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :stat_increment_points, :integer, default: 0
  end
end
