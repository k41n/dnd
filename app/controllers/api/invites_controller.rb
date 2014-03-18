class Api::InvitesController < ApplicationController
  respond_to :json
  inherit_resources

  def accept
    resource.accept
    head :ok
  end

  protected

  def begin_of_association_chain
    current_player
  end

  def resource
    @invite ||= GameInvitation.find(params[:id])
  end
end