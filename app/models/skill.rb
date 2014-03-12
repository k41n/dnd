class Skill < ActiveRecord::Base
  has_many :skill_assignments
  has_many :monsters, through: :skill_assignments, source: :owner, source_type: 'Monster'
  has_many :characters, through: :skill_assignments, source: :owner, source_type: 'Character'
  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-skill.png'
end