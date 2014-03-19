class AddAcToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :ac, default: 0
    end
  end
end
