class AddTrainingsCountToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :trainings_count, default: 0
    end
  end
end
