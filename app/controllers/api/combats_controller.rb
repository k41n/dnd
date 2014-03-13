class Api::CombatsController < ApplicationController
  respond_to :json
  inherit_resources
  belongs_to :game, optional: true  
  before_filter :authenticate_player!, only: [:create]

  def background
    @combat = Combat.find(params[:id])
    @combat.background = params[:file]
    @combat.save
    render json: { answer: 'File transfer completed', url: @combat.background.url }
  end

  protected

  def collection
    end_of_association_chain.order(:created_at).page(params[:page])
  end

  def permitted_params
    params.permit(combat: [:name, :description, :json])
  end

end
