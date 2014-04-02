class CreateHumanFlexibilityPerk < ActiveRecord::Migration
  def change
    Perk.create!(name: 'Человеческая гибкость', description: '+2 к одному значению характеристики на ваш выбор', js_class: 'Perks.HumanFlexibility')
  end
end
