class AddRogueTacticsPerk < ActiveRecord::Migration
  def change
	Perk.create!(name: 'Тактика плута', description: '', js_class: 'Perks.RogueTactics')  	
  end
end
