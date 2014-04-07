class AddPerkSettingsToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :perk_settings, :text
  end
end
