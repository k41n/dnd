class CreateCharacterAvailabilities < ActiveRecord::Migration
  def change
    create_table :character_availabilities do |t|
      t.references :skill
      t.references :character_class
      t.timestamps
    end
  end
end
