ActiveAdmin.register Weapon do
  permit_params :title, :damage_dice, :damage_count, :prof

  index do
    id_column
    column :title
    column :damage_dice
    column :damage_count
    column :prof
    actions
  end

  form do |f|
    f.inputs 'Weapon Details' do
      f.input :title
      f.input :damage_dice
      f.input :damage_count
      f.input :prof
    end
    f.actions
  end

end