class AddSizeToRaces < ActiveRecord::Migration
  def change
    change_table :races do |t|
      t.string :size
    end
  end
end
