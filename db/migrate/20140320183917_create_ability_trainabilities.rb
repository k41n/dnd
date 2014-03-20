class CreateAbilityTrainabilities < ActiveRecord::Migration
  def change
    create_table :ability_trainabilities do |t|
      t.references :character_class
      t.references :character_ability
      t.timestamps
    end
  end
end
