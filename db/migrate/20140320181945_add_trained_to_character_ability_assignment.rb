class AddTrainedToCharacterAbilityAssignment < ActiveRecord::Migration
  def change
    add_column :character_ability_assignments, :trained, :boolean, default: false
  end
end
