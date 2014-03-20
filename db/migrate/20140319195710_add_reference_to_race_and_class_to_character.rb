class AddReferenceToRaceAndClassToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.references :race
      t.references :character_class
    end
  end
end
