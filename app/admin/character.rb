ActiveAdmin.register Character do
  permit_params :name, :player, :avatar

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :player, as: :select, collection: Player.pluck(:email, :id)
      f.input :avatar, as: :file
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