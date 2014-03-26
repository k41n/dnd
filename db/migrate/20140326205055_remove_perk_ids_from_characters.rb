class RemovePerkIdsFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :perk_ids
  end
end
