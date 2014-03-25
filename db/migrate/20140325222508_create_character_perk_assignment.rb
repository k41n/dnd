class CreateCharacterPerkAssignment < ActiveRecord::Migration
  def change
    create_table :character_perk_assignments do |t|
      t.references :character
      t.references :perk
    end
  end
end
