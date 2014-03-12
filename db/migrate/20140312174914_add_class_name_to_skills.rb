class AddClassNameToSkills < ActiveRecord::Migration
  def change
    change_table :skills do |t|
      t.string :js_class
    end
  end
end
