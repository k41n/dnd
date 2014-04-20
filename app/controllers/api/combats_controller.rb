class Api::CombatsController < ApplicationController
  respond_to :json
  inherit_resources
  belongs_to :game, optional: true  
  before_filter :authenticate_player!, only: [:create]
  before_filter :find_combat, only: [:background, :reset, :update]

  def background
    @combat.background = params[:file]
    @combat.save
    render json: { answer: 'File transfer completed', url: @combat.background.url }
  end

  def reset
    @combat.reset_json
    render json: { success: true }    
  end

  def update
    @combat.assign_attributes(permitted_params[:combat])
    @combat[:json_orig] = @combat.json if params[:reset]
    if @combat.save
      render json: { success: true}
    else
      render json: { success: false, errors: @combat.errors.full_messages }
    end   

  end

  protected

  def collection
    end_of_association_chain.order(:created_at).page(params[:page])
  end

  def permitted_params
    params.permit(combat: [:name, :description, :json])
  end

  def find_combat
    @combat = Combat.find(params[:id])
  end

end
