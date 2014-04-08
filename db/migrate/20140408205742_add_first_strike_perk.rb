class AddFirstStrikePerk < ActiveRecord::Migration
  def change
	Perk.create!(name: 'Первый удар', description: 'Боевое превосходство над неходившими в сцене', js_class: 'Perks.FirstStrike')  	  	
  end
end
