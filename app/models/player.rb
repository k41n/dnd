class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable

  has_many :games, foreign_key: :master_id
  has_many :characters

  def invites
    GameInvitation.where(character_id: characters.map(&:id))
  end

end
