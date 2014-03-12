class ChangeTableMonsters < ActiveRecord::Migration
  def up
    remove_column :monsters, :role
    remove_column :monsters, :action_points
    remove_column :monsters, :xp
    remove_column :monsters, :save_rolls
    add_column :monsters, :str, :integer, default: 0
    add_column :monsters, :con, :integer, default: 0
    add_column :monsters, :dex, :integer, default: 0
    add_column :monsters, :int, :integer, default: 0
    add_column :monsters, :wis, :integer, default: 0
    add_column :monsters, :cha, :integer, default: 0
  end

  def down
    add_column :monsters, :role, :string
    add_column :monsters, :action_points, :integer
    add_column :monsters, :xp, :integer
    add_column :monsters, :save_rolls, :integer
    remove_column :monsters, :str
    remove_column :monsters, :con
    remove_column :monsters, :dex
    remove_column :monsters, :int
    remove_column :monsters, :wis
    remove_column :monsters, :cha
  end
end
