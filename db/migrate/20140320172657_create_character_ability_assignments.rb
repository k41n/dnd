class CreateCharacterAbilityAssignments < ActiveRecord::Migration
  def change
    create_table :character_ability_assignments do |t|
      t.references :character
      t.references :character_ability
      t.integer :mastery
      t.timestamps
    end
  end
end
