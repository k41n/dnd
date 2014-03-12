class AddAvatarToSkill < ActiveRecord::Migration
  def change
    change_table :skills do |t|
      t.attachment :avatar
    end
  end
end
