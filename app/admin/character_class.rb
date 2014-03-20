ActiveAdmin.register CharacterClass do
  permit_params :name, 
    :description, 
    :avatar,
    :js_class

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Class" do
      f.input :name
      f.input :description
      f.input :js_class
      f.input :avatar, as: :file
    end
    f.actions
  end


end
