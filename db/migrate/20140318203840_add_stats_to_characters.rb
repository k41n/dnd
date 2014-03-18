class AddStatsToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :str, default: 10
      t.integer :con, default: 10
      t.integer :dex, default: 10
      t.integer :int, default: 10
      t.integer :wis, default: 10
      t.integer :cha, default: 8
      t.integer :speed, default: 6
    end
  end
end
