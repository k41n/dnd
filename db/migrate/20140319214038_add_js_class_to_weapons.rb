class AddJsClassToWeapons < ActiveRecord::Migration
  def change
    change_table :weapons do |t|
      t.string :js_class
    end
  end
end
