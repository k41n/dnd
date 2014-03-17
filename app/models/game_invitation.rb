class GameInvitation < ActiveRecord::Base
  belongs_to :character
  belongs_to :game

  validates :character, uniqueness: { scope: :game }
end
