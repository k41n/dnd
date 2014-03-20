class AddReferencesToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.references :armor
      t.references :shield
      t.references :weapon
    end
  end
end
