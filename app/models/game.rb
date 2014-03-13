class Game < ActiveRecord::Base
  include FayeObservable


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
