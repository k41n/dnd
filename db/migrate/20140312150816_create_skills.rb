class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :title
      t.string :attack_char_from
      t.string :attack_char_to
      t.integer :damage_dice, default: 0
      t.integer :damage_count, default: 1
      t.integer :damage_bonus, default: 0
      t.string :owner_type
      t.integer :owner_id
    end
    add_index :skills, :owner_id
  end
end
