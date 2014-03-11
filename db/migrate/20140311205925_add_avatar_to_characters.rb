class AddAvatarToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.attachment :avatar
    end
  end
end
