class AddInitiativeBonusToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :initiative_bonus
    end
  end
end
