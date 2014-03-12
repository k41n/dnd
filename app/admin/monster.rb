ActiveAdmin.register Monster do

  permit_params :name, 
    :description, 
    :avatar,
    :monster_type, 
    :level,
    :size, 
    :hp, 
    :initiative, 
    :ac, 
    :endurance,
    :reaction,
    :will,
    :speed,
    :str,
    :con,
    :dex,
    :int,
    :wis,
    :cha,
    :skill_ids => []

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :skills, as: :check_boxes
      f.input :avatar, as: :file
      f.input :monster_type
      f.input :level
      f.input :size
      f.input :hp
      f.input :initiative
      f.input :ac
      f.input :endurance
      f.input :reaction
      f.input :will
      f.input :speed
      f.input :str
      f.input :con
      f.input :dex
      f.input :int
      f.input :wis
      f.input :cha

    end
    f.actions
  end

  index do
    column :name
    column :level
    column :avatar do |m|
      image_tag m.avatar.url(:thumb), size: '25x25'
    end
    column :hp
    column :ac
    actions
  end
end
