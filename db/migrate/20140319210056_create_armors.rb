class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |t|
      t.string :name
      t.string :description
      t.string :js_class
      t.integer :ac_bonus
      t.attachment :avatar
      t.timestamps
    end
  end
end
