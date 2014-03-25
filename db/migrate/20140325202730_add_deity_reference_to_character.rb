class AddDeityReferenceToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.references :deity
    end
  end
end
