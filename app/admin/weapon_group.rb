ActiveAdmin.register WeaponGroup do
  permit_params :name, :description

  index do
    id_column
    column :name
    column :description
    actions
  end

  form do |f|
    f.inputs 'Weapon Group Details' do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
