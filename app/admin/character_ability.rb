ActiveAdmin.register CharacterAbility do
  permit_params :name, 
    :description, 
    :avatar,
    :js_class,
    :character_ability_ids

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Character ability" do
      f.input :name
      f.input :description
      f.input :js_class
      f.input :avatar, as: :file
      f.input :character_abilities, as: :checkboxes
    end
    f.actions
  end
end
