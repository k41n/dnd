class Api::SkillsController < ApplicationController
  respond_to :json
  inherit_resources
  before_filter :authenticate_player!, only: [:update, :create, :destroy]

  protected

  def collection
    end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    current_player
  end

  def permitted_params
    params.permit(skill: [:title, :attack_char_from, :attack_char_to, :damage_dice, :damage_count, :damage_bonus, :owner_type, :owner_id])
  end

end