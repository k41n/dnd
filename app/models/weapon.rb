class Weapon < ActiveRecord::Base
  has_many :weapon_assignments
  has_many :monsters, through: :weapon_assignments, source: :owner, source_type: 'Monster'
  has_many :characters, through: :weapon_assignments, source: :owner, source_type: 'Character'
end