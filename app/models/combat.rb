class Combat < ActiveRecord::Base
  belongs_to :game

  paginates_per 10
end
