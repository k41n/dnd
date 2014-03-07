ActiveAdmin.register Monster do

  permit_params :name, 
    :description, 
    :avatar, 
    :role, 
    :monster_type, 
    :level, 
    :xp, 
    :size, 
    :hp, 
    :initiative, 
    :ac, 
    :endurance,
    :reaction,
    :will,
    :save_rolls,
    :speed,
    :action_points

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :avatar, as: :file
      f.input :role
      f.input :monster_type
      f.input :level
      f.input :xp
      f.input :size
      f.input :hp
      f.input :initiative
      f.input :ac
      f.input :endurance
      f.input :reaction
      f.input :will
      f.input :save_rolls
      f.input :speed
      f.input :action_points

    end
    f.actions
  end

  index do
    column :name
    column :level
    column :avatar do |m|
      image_tag m.avatar.url(:thumb), size: '25x25>'
    end
    column :hp
    column :ac
    actions
  end
end
