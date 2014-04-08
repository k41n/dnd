class AddWeaponFocusPerk < ActiveRecord::Migration
  def change
  	Perk.create!(name: 'Фокусировка на оружии', description: '', js_class: 'Perks.WeaponFocus')
  end
end
