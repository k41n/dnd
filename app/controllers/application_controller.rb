class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :debug_current_user
  before_filter :set_faye_host
  before_filter :set_player_in_gon

  rescue_from ActiveRecord::RecordNotFound do
    render json: {error: 'not_found'}, status: :not_found
  end

  private

  def debug_current_user
    Rails.logger.info "------------ player_signed_in?: #{player_signed_in?}"
    Rails.logger.info "------------ current_player: #{current_player || 'Anonymous'}"
    session.keys.each do |k|
      Rails.logger.info("#{k} = #{session[k]}")
    end
  end

  def set_faye_host
    gon.faye_host = App.faye_host
  end

  def set_player_in_gon
    gon.player = current_player
  end


end
