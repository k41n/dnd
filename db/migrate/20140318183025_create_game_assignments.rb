class CreateGameAssignments < ActiveRecord::Migration
  def change
    create_table :game_assignments do |t|
      t.references :game
      t.references :character
      t.timestamps
    end
  end
end
