class AddAvatarToWeapon < ActiveRecord::Migration
  def change
    change_table :weapons do |t|
      t.attachment :avatar
    end
  end
end
