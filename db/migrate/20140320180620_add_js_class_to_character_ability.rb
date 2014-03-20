class AddJsClassToCharacterAbility < ActiveRecord::Migration
  def change
    change_table :character_abilities do |t|
      t.string :js_class
    end
  end
end
