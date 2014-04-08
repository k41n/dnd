class CreateWeaponGroups < ActiveRecord::Migration
  def change
    create_table :weapon_groups do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
