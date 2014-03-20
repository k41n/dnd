ActiveAdmin.register CharacterClass do
  permit_params :name, 
    :description, 
    :avatar,
    :js_class,
    character_ability_ids: []

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Class" do
      f.input :name
      f.input :description
      f.input :js_class
      f.input :avatar, as: :file
      f.input :character_abilities, as: :check_boxes
    end
    f.actions
  end

  index do
    column :name
    column :avatar do |m|
      image_tag m.avatar.url(:thumb), size: '25x25'
    end
    actions
  end

end
