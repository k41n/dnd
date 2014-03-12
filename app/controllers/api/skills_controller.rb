class Api::SkillsController < ApplicationController
  respond_to :json
  inherit_resources

  protected

  def permitted_params
    params.permit(skill: [:title, :attack_char_from, :attack_char_to, :damage_dice, :damage_count, :damage_bonus, :owner_type, :owner_id])
  end

end