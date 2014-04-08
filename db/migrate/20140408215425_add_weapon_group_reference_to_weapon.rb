class AddWeaponGroupReferenceToWeapon < ActiveRecord::Migration
  def change
  	change_table :weapons do |t|
  	  t.references :weapon_group
  	end
  end
end
