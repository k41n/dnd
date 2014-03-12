ActiveAdmin.register Skill do
  permit_params :title, :attack_char_from, :attack_char_to, :damage_dice, :damage_count, :damage_bonus, :owner_type, :owner_id

  form do |f|
    f.inputs "Skill Details" do
      f.input :title
      f.input :owner_type
      f.input :owner_id
      f.input :attack_char_from, as: :select, collection: %w|str con dex int wis cha|
      f.input :attack_char_to, as: :select, collection: %w|ac endurance reaction will|
      f.input :damage_dice
      f.input :damage_count
      f.input :damage_bonus
    end
    f.actions
  end

end