class Monster < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :thumb => "50x50" }
  has_many :skill_assignments, as: :owner
  has_many :skills, through: :skill_assignments


end
