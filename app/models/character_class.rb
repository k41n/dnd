class CharacterClass < ActiveRecord::Base
  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-character.png'
end
