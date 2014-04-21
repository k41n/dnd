ActiveAdmin.register Game do
  permit_params :name,
    :description

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Game" do
      f.input :name
      f.input :description
    end
    f.actions
  end

  index do
    column :name
    column :description
    actions
  end
  
end
