class WeaponAssignment < ActiveRecord::Base
  belongs_to :weapon
  belongs_to :owner, polymorphic: true
end