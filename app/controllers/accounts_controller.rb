class AccountsController < ApplicationController

  layout "startup"

  def signup
    case request.method
      when "GET"
      	@user = User.new
      when "POST"
        respond_to do |format|
      	  @user = User.new(user_params)
      	  if @user.save
      	  	flash[:notice] = 'You Are Successfully Signed Up. Please Log In'
      	  	format.html { redirect_to account_login_path }
      	  else
      	  	format.html { render :signup }
      	  end
      	end
    end
  end	

  def login
  	case request.method
  	  when "POST"
  	  	respond_to do |format|
  	  	  @user = User.authenticate(params[:login], params[:password])

  	  	  if @user
  	  	  	session[:user_id] = @user.id
  	  	  	session[:user_login] = @user.login
  	  	  	flash[:notice] = "Welcome #{session[:user_login]}" 
  	  	  	format.html {  redirect_to :controller => "devices", :action => "index" }
  	  	  else
  	  	  	flash[:notice] = 'Invalid Username/Password'
            format.html { redirect_to account_login_path }
          end
        end
  	end
  end

  def logout
  	respond_to do |format|
  	  session[:user_id] = nil
  	  flash[:notice] = 'User Successfully Logged Out'
  	  format.html { redirect_to account_login_path }
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:login, :email, :password)
  end

end

