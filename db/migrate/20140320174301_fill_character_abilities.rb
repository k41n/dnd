class FillCharacterAbilities < ActiveRecord::Migration
  def change
    CharacterAbility.create(name: 'Акробатика', dependent_on_stat: 'dex')
    CharacterAbility.create(name: 'Атлетика', dependent_on_stat: 'str')
    CharacterAbility.create(name: 'Внимательность', dependent_on_stat: 'wis')
    CharacterAbility.create(name: 'Воровство', dependent_on_stat: 'dex')
    CharacterAbility.create(name: 'Выносливость', dependent_on_stat: 'con')
    CharacterAbility.create(name: 'Запугивание', dependent_on_stat: 'cha')
    CharacterAbility.create(name: 'Знание улиц', dependent_on_stat: 'cha')
    CharacterAbility.create(name: 'История', dependent_on_stat: 'int')
    CharacterAbility.create(name: 'Магия', dependent_on_stat: 'int')
    CharacterAbility.create(name: 'Обман', dependent_on_stat: 'cha')
    CharacterAbility.create(name: 'Переговоры', dependent_on_stat: 'cha')
    CharacterAbility.create(name: 'Подземелья', dependent_on_stat: 'wis')
    CharacterAbility.create(name: 'Природа', dependent_on_stat: 'wis')
    CharacterAbility.create(name: 'Проницательность', dependent_on_stat: 'wis')
    CharacterAbility.create(name: 'Религия', dependent_on_stat: 'int')
    CharacterAbility.create(name: 'Скрытность', dependent_on_stat: 'dex')
    CharacterAbility.create(name: 'Целительство', dependent_on_stat: 'wis')
  end
end
