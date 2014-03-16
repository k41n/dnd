ActiveAdmin.register Race do
  permit_params :name, 
    :description, 
    :avatar,
    :js_class
   
end
