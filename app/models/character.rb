class Character < ActiveRecord::Base
  include FayeObservable    
  belongs_to :player
  has_many :skill_assignments, as: :owner, dependent: :destroy
  has_many :skills, through: :skill_assignments
  has_many :weapon_assignments, as: :owner, dependent: :destroy
  has_many :weapons, through: :weapon_assignments
  has_many :game_invitations, dependent: :destroy
  has_many :games_invited_to, through: :game_invitations, source: :game
  has_many :game_assignments, dependent: :destroy
  has_many :games_assigned_to, through: :game_assignments, source: :game

  has_many :character_perk_assignments
  has_many :perks, through: :character_perk_assignments

  has_many :character_ability_assignments
  has_many :character_abilities, through: :character_ability_assignments

  belongs_to :race
  belongs_to :character_class
  belongs_to :armor
  #belongs_to :shield
  belongs_to :weapon
  belongs_to :deity

  has_attached_file :avatar, styles: { thumb: '50x50' }, default_url: '/unknown-character.png'

  paginates_per 10  

  def invite_to(game)
    game_invitations.create!(game: game)
  end

  def assign_to(game)
    game_assignments.create!(game: game)
  end

  def uninvite_from(game)
    games_invited_to.destroy(game)
  end

  def kick_from(game)
    games_assigned_to.destroy(game)
  end

  def invited_to?(game)
    games_invited_to.include?(game)
  end

  def as_json(options = {})
    super(methods: [:perk_ids, :skill_ids] )
  end
end
