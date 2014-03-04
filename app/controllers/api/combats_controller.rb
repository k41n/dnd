class Api::CombatsController < ApplicationController
  respond_to :json
  inherit_resources
  before_filter :authenticate_player!, only: [:create]

  protected

  def collection
    end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    current_game
  end

  def permitted_params
    params.permit(combat: [:name, :description])
  end

  def current_game
    @game ||= Game.find(params[:game_id])
  end

end
