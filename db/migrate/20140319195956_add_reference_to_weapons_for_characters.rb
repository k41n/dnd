class AddReferenceToWeaponsForCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.references :right_hand_weapon
      t.references :left_hand_weapon
    end
  end
end
