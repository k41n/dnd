class AddUndercoverAttackPerk < ActiveRecord::Migration
  def change
  	Perk.create!(name: 'Скрытая атака', description: 'Если есть боевое превосходство и было попадание - доп. урон один раз за ход', js_class: 'Perks.UndercoverAttack')
  end
end
