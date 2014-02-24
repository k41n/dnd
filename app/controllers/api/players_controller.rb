class Api::PlayersController < ApplicationController
  def index
    @players = Player.all
    Rails.logger.info "@players = #{@players}"
  end
end
