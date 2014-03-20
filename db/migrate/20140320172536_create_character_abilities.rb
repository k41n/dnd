class CreateCharacterAbilities < ActiveRecord::Migration
  def change
    create_table :character_abilities do |t|
      t.attachment :avatar
      t.string :name
      t.text :description
      t.string :dependent_on_stat
      t.timestamps
    end
  end
end
