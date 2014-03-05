class Combat < ActiveRecord::Base
  include FayeObservable  
  belongs_to :game

  paginates_per 10
end
