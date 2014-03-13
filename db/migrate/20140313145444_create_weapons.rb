class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :title
      t.integer :damage_dice, default: 0
      t.integer :damage_count, default: 1
      t.integer :prof, default: 0
      t.timestamps
    end

    create_table :weapon_assignments do |t|
      t.string :owner_type
      t.integer :owner_id
      t.references :weapon
    end
    add_index :weapon_assignments, :owner_id
  end
end
