class CreateCombats < ActiveRecord::Migration
  def change
    create_table :combats do |t|
      t.string :name
      t.text :description
      t.references :game
      t.timestamps
    end
  end
end
