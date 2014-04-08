class AddAuxFlagToWeapons < ActiveRecord::Migration
  def change
  	add_column :weapons, :aux, :boolean, default: false
  end
end
