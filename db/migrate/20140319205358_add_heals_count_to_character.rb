class AddHealsCountToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :heals_count, default: 0
    end
  end
end
