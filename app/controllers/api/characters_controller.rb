class Api::CharactersController < ApplicationController
  respond_to :json
  inherit_resources
  before_filter :authenticate_player!, only: [:update, :create, :destroy, :my]

  def avatar
    @character = Character.find(params[:id])
    @character.avatar = params[:file]
    @character.save
    render json: { answer: 'File transfer completed', url: @character.avatar.url(:thumb) }
  end

  def my
    @characters = current_player.characters
    render :index
  end

  def invite
    @game = Game.find(params[:gameId])
    @character = Character.where(name: params[:name]).first
    if @game && @character
      @result = @character.invite_to(@game)
      head :ok
    else
      head :not_found
    end
  rescue ActiveRecord::RecordInvalid
    @result = false
    head :unprocessable_entity
  end

  def accept
    @invitation = GameInvitation.find(params[:invitation_id])
    @invitation.accept
    head :ok
  end

  def uninvite
    @game = Game.find(params[:gameId])
    @character = Character.where(name: params[:name]).first
    if @game && @character
      @result = @character.uninvite_from(@game)
      head :ok
    else
      head :not_found
    end
  rescue ActiveRecord::RecordInvalid
    @result = false
    head :unprocessable_entity
  end

  def kick
    @game = Game.find(params[:gameId])
    @character = Character.where(name: params[:name]).first
    if @game && @character
      @result = @character.kick_from(@game)
      head :ok
    else
      head :not_found
    end
  rescue ActiveRecord::RecordInvalid
    @result = false
    head :unprocessable_entity
  end

  protected

  def collection
    @characters ||= end_of_association_chain.page(params[:page])
  end

  def begin_of_association_chain
    current_player
  end

  def permitted_params
    params.permit(character: [:name])
  end

end
