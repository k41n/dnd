class Game < ActiveRecord::Base
  include FayeObservable

  has_many :game_invitations
  has_many :invited_characters, through: :game_invitations, source: :character

  has_many :game_assignments
  has_many :assigned_characters, through: :game_assignments, source: :character

  paginates_per 10

  belongs_to :master, class_name: 'Player'
  has_many :combats

  validates :name, presence: true

  def as_json(options={})
    {
        id: id,
        name: name,
        master: master.email,
        master_id: master.id,
        description: description
    }
  end
end
