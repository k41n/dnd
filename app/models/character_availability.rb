class CharacterAvailability < ActiveRecord::Base
  belongs_to :skill
  belongs_to :character_class
end
