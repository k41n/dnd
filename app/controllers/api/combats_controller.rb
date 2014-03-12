class Api::CombatsController < ApplicationController
  respond_to :json
  inherit_resources
  belongs_to :game, optional: true  
  before_filter :authenticate_player!, only: [:create]

  protected

  def collection
    end_of_association_chain.order(:created_at).page(params[:page])
  end

  def permitted_params
    params.permit(combat: [:name, :description, :json])
  end

end
