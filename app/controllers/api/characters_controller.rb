class Api::CharactersController < ApplicationController
  respond_to :json
  inherit_resources
  before_filter :authenticate_player!, only: [:update, :create, :destroy]

  def avatar
    @character = Character.find(params[:id])
    @character.avatar = params[:file]
    @character.save
    render json: { answer: 'File transfer completed', url: @character.avatar.url(:thumb) }
  end

  protected

  def collection
    end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    current_player
  end

  def permitted_params
    params.permit(character: [:name])
  end

end
