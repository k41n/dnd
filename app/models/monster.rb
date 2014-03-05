class Monster < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :thumb => "50x50" }

end
