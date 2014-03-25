class AddAvatarToDeities < ActiveRecord::Migration
  def change
    change_table :deities do |t|
      t.attachment :avatar
    end
  end
end
