class AddAvatarToCharacterClass < ActiveRecord::Migration
  def change
    change_table :character_classes do |t|
      t.attachment :avatar
    end
  end
end
