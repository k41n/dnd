class AddSavesToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :stamina, default: 0
      t.integer :reaction, default: 0
      t.integer :will, default: 0
    end
  end
end
