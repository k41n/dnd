ActiveAdmin.register Monster do

  permit_params :name, :description, :avatar  

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :avatar, as: :file
    end
    f.actions
  end
end
