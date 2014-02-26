class Game < ActiveRecord::Base
  paginates_per 10

  belongs_to :master, class_name: 'Player'

  validates :name, presence: true

  def as_json(options={})
    {
        name: name,
        master: master.name,
        description: description
    }
  end
end
