class AddHighCritFlagToWeapons < ActiveRecord::Migration
  def change
  	add_column :weapons, :high_crit, :boolean, default: false
  end
end
