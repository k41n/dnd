class Combat < ActiveRecord::Base
  include FayeObservable  
  belongs_to :game

  paginates_per 10

  def as_json(options={})
    {
        id: id,
        name: name,
        description: description,
        game_id: game_id,
        json: json
    }
  end

end
