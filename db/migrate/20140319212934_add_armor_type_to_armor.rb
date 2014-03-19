class AddArmorTypeToArmor < ActiveRecord::Migration
  def change
    change_table :armors do |t|
      t.string :armor_type
    end
  end
end
