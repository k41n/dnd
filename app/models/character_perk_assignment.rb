class CharacterPerkAssignment < ActiveRecord::Base
  belongs_to :perk
  belongs_to :character
end
