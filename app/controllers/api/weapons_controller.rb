class Api::WeaponsController < ApplicationController
  respond_to :json
  inherit_resources

  protected

  def permitted_params
    params.permit(weapon: [:title, :attack_char_from, :attack_char_to, :damage_dice, :damage_count, :prof])
  end

end