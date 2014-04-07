class CharacterAbilityAssignment < ActiveRecord::Base
  belongs_to :character_ability
  belongs_to :character
end
