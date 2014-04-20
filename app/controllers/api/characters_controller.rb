class Api::CharactersController < ApplicationController
  respond_to :json
  inherit_resources
  before_filter :authenticate_player!, only: [:update, :create, :destroy, :my]
  skip_before_filter :verify_authenticity_token

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

  def build_resource_params
    [ params.permit(:name, :str, :con, :dex, :int, :wis, :cha, :speed, :xp, :level, :stat_points, :hp, :max_hp, :stamina, :reaction, :will, :ac, :race_id, :character_class_id, :armor_id, :shield_id, :weapon_id, :deity_id, :perk_settings, character_ability_ids: [], perk_ids: [], skill_ids: [] ) ]
  end

end
