class AddPlusOneToTwoFourthLevelPerk < ActiveRecord::Migration
  def change
    Perk.create!(name: '+1 к 2 на 4', description: '+1 к двум разным значениям характеристик на ваш выбор', js_class: 'Perks.Plus122on4')    
  end
end
