class Character < ActiveRecord::Base
  include FayeObservable    
  belongs_to :player
  has_many :skill_assignments, as: :owner
  has_many :skills, through: :skill_assignments

  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-character.png'

  paginates_per 10  

end
