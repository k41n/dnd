class Character < ActiveRecord::Base
  include FayeObservable    
  belongs_to :player
  has_many :skill_assignments, as: :owner
  has_many :skills, through: :skill_assignments
  has_many :weapon_assignments, as: :owner
  has_many :weapons, through: :weapon_assignments
  has_many :game_invitations
  has_many :games_invited_to, through: :game_invitations, source: :game

  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-character.png'

  paginates_per 10  

  def invite_to(game)
    games_invited_to << game
  end

  def uninvite_from(game)
    games_invited_to.destroy(game)
  end

  def invited_to?(game)
    games_invited_to.include?(game)
  end

end
