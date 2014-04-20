class AddJsonOrigToCombats < ActiveRecord::Migration
  def change
    add_column :combats, :json_orig, :text, limit: 1.gigabyte - 1
  end
end
