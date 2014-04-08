class Weapon < ActiveRecord::Base
  has_many :weapon_assignments, dependent: :destroy
  has_many :monsters, through: :weapon_assignments, source: :owner, source_type: 'Monster'
  has_many :characters, through: :weapon_assignments, source: :owner, source_type: 'Character'
  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-weapon.png'
  belongs_to :weapon_group
end