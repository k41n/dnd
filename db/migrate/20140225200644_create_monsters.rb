class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.attachment :avatar
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
