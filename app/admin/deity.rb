ActiveAdmin.register Deity do
  permit_params :name, :description, :avatar

  form do |f|
    f.inputs 'Deity Details' do
      f.input :name
      f.input :avatar, as: :file
      f.input :description
    end
    f.actions
  end

end
