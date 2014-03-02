class Api::GamesController < ApplicationController
  respond_to :json
  inherit_resources
  before_filter :authenticate_player!, only: [:create]
  before_filter :check_game_master, only: [:destroy]


  protected

  def collection
    end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    current_player
  end

  def permitted_params
    params.permit(game: [:name, :description])
  end

  def check_game_master
    render head: :not_authorized unless resource && resource.master_id == current_player.try(:id)
  end
end
