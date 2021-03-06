class GameInvitation < ActiveRecord::Base
  include FayeObservable

  belongs_to :character
  belongs_to :game

  validates :game, presence: true
  validates :character, uniqueness: { scope: :game }, presence: true

  def accept
    destroy    
    character.assign_to(game)
  end
end
