class CreateCharacterClasses < ActiveRecord::Migration
  def change
    create_table :character_classes do |t|
      t.string :name
      t.text   :description
      t.string :js_class
      t.timestamps
    end
  end
end
