class Combat < ActiveRecord::Base
  include FayeObservable  
  belongs_to :game

  has_attached_file :background, default_url: '/unknown-terrain.jpg'

  paginates_per 10

  def reset_json
    self.update_attribute(:json, json_orig)
  end

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
