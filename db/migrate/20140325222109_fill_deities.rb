class FillDeities < ActiveRecord::Migration
  def change
    Deity.destroy_all
    Deity.create(name: 'Авандра')
    Deity.create(name: 'Бахамут')
    Deity.create(name: 'Йоун')
    Deity.create(name: 'Корд')
    Deity.create(name: 'Кореллон')
    Deity.create(name: 'Королева Воронов')
    Deity.create(name: 'Мелора')
    Deity.create(name: 'Морадин')
    Deity.create(name: 'Пелор')
    Deity.create(name: 'Сеанин')
    Deity.create(name: 'Эратис')
  end
end
