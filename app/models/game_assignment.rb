class GameAssignment < ActiveRecord::Base
  belongs_to :character
  belongs_to :game

  validates :game, presence: true
  validates :character, uniqueness: { scope: :game }, presence: true

end
