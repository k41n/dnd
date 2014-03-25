class AddPerkIdsToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :perk_ids, array: true, default: []
    end
  end
end
