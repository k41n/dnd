class AddRogueWeaponProficiencyPerk < ActiveRecord::Migration
  def change
	Perk.create!(name: 'Оружейное дарование плута', description: '+1 к атаке кинжалом или сюрикеном', js_class: 'Perks.RogueWeaponProficiency')  	
  end
end
