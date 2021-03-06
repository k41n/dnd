ActiveAdmin.register Race do
  permit_params :name, 
    :description, 
    :avatar,
    :js_class
    :size

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Race" do
      f.input :name
      f.input :description
      f.input :js_class
      f.input :size, as: :select, collection: [ 'Small', 'Average', 'Large' ]
      f.input :avatar, as: :file
    end
    f.actions
  end

   
end
