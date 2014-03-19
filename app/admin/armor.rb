ActiveAdmin.register Armor do
  permit_params :name, 
    :description, 
    :avatar,
    :js_class,
    :ac_bonus,
    :armor_type

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Armor" do
      f.input :name
      f.input :description
      f.input :js_class
      f.input :ac_bonus
      f.input :armor_type, as: :select, collection: [ 'Light', 'Heavy', 'Shield' ]
      f.input :avatar, as: :file
    end
    f.actions
  end
end
