class AddBackgroundToCombats < ActiveRecord::Migration
  def change
    change_table :combats do |t|
      t.attachment :background
    end
  end
end
