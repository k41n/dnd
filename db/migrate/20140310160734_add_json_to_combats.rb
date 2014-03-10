class AddJsonToCombats < ActiveRecord::Migration
  def change
    change_table :combats do |t|
      t.text :json, limit: 1.gigabyte - 1
    end
  end
end
