class AddCharacterAbilityIdsToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :character_ability_ids, array: true, default: []      
    end
  end
end
