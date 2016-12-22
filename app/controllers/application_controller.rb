class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]
  end

  private

  def authenticate_user!
  	redirect_to account_login_path, notice: 'Not Authorized' if current_user.nil?
  end
  
end
