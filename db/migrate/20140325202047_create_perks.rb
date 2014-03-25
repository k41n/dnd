class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.string :name
      t.text :description
      t.string :js_class
      t.timestamps
    end
  end
end
