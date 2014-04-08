ActiveAdmin.register Weapon do
  permit_params :title, :damage_dice, :damage_count, :prof, :avatar, :js_class, :weapon_group_id, :aux, :high_crit

  index do
    id_column
    column :title
    column :avatar do |obj|
      image_tag obj.avatar.url(:thumb), size: '25x25'
    end
    column :damage_dice
    column :damage_count
    column :prof
    column :weapon_group
    column :flags do |obj|
      ret = []
      ret << 'Дополнительное' if obj.aux?
      ret << 'Высококритичное' if obj.high_crit?
      ret.join(', ')
    end
    actions
  end

  form do |f|
    f.inputs 'Weapon Details' do
      f.input :title
      f.input :avatar, as: :file
      f.input :js_class
      f.input :damage_dice
      f.input :damage_count
      f.input :weapon_group
      f.input :prof
      f.input :aux
      f.input :high_crit
    end
    f.actions
  end

end