class AbilityTrainability < ActiveRecord::Base
  belongs_to :character_ability
  belongs_to :character_class
end
