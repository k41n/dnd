class AddAttackCharFromToWeapons < ActiveRecord::Migration
  def change
    change_table :weapons do |t|
      t.string :attack_char_from
      t.string :attack_char_to
    end
  end
end
