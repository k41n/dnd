ActiveAdmin.register Character do
  permit_params :name, :player, :avatar, skill_ids: [], weapon_ids: []

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :player, as: :select, collection: Player.pluck(:email, :id)
      f.input :avatar, as: :file
      f.input :skills, as: :check_boxes
      f.input :weapons, as: :check_boxes
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