class CharacterClass < ActiveRecord::Base
  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-character.png'

  has_many :ability_trainabilities
  has_many :character_abilities, through: :ability_trainabilities
end
