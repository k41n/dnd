class FillCharacterClasses < ActiveRecord::Migration
  def change
    CharacterClass.create(name: 'Военачальник', js_class: 'CharacterClasses.Warlord')
    CharacterClass.create(name: 'Воин', js_class: 'CharacterClasses.Warrior')
    CharacterClass.create(name: 'Волшебник', js_class: 'CharacterClasses.Mage')
    CharacterClass.create(name: 'Жрец', js_class: 'CharacterClasses.Priest')
    CharacterClass.create(name: 'Колдун', js_class: 'CharacterClasses.Warlock')
    CharacterClass.create(name: 'Паладин', js_class: 'CharacterClasses.Paladin')
    CharacterClass.create(name: 'Плут', js_class: 'CharacterClasses.Rogue')
    CharacterClass.create(name: 'Следопыт', js_class: 'CharacterClasses.Ranger')
  end
end
