class CreateDeities < ActiveRecord::Migration
  def change
    create_table :deities do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
