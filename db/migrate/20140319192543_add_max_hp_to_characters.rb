class AddMaxHpToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :hp, default: 0
      t.integer :max_hp, default: 0
    end
  end
end
