class SessionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :destroy]

  respond_to :json

  def create
    resource = Player.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      render json: { success: true, user: { email: resource.email } }
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out
    render :json=> {:success=>true}
  end

  protected

  def ensure_params_exist
    return unless params[:user].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end