class Monster < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :thumb => "50x50" }
  has_many :skill_assignments, as: :owner
  has_many :skills, through: :skill_assignments
  has_many :weapon_assignments, as: :owner
  has_many :weapons, through: :weapon_assignments

end
