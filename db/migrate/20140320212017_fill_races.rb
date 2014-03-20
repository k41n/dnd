class FillRaces < ActiveRecord::Migration
  def change
    Race.destroy_all
    Race.create(name: 'Гном', js_class: 'Races.Dwarf')
    Race.create(name: 'Драконорожденный', js_class: 'Races.Dragonborn')
    Race.create(name: 'Хоббит', js_class: 'Races.Halfling')
    Race.create(name: 'Полуэльф', js_class: 'Races.Halfelf')
    Race.create(name: 'Тифлинг', js_class: 'Races.Teephling')
    Race.create(name: 'Человек', js_class: 'Races.Human')
    Race.create(name: 'Эладрин', js_class: 'Races.Eladrin')
    Race.create(name: 'Эльф', js_class: 'Races.Elf')
  end
end
