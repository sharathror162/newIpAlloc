class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
  	redirect_to account_login_path, notice: 'Not Authorized' if current_user.nil?
  end
  
end
