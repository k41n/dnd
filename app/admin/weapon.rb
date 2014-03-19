ActiveAdmin.register Weapon do
  permit_params :title, :damage_dice, :damage_count, :prof, :avatar, :js_class

  index do
    id_column
    column :title
    column :avatar do |obj|
      image_tag obj.avatar.url(:thumb), size: '25x25'
    end
    column :damage_dice
    column :damage_count
    column :prof
    actions
  end

  form do |f|
    f.inputs 'Weapon Details' do
      f.input :title
      f.input :avatar, as: :file
      f.input :js_class
      f.input :damage_dice
      f.input :damage_count
      f.input :prof
    end
    f.actions
  end

end