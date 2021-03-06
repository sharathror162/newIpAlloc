class AccountsController < ApplicationController

  before_action :set_user, only: [:activate]
  before_action :check_token_expiration, only: [:reset_approved]

  def signup
    case request.method
      when "GET"
      	@user = User.new
      when "POST"
        respond_to do |format|
      	  @user = User.new(user_params)
          unless User.find_by_email(@user.email).present?
            if @user.save
              EmailSenderJob.perform_later(@user)
              flash[:notice] = "Your account has been Successfully created and an activation link has been sent to
                                 your email #{@user.email}. Please check your inbox to activate your account."
              format.html { redirect_to account_login_path }
            else
              format.html { render :signup }
            end
          else
            flash.now[:notice] = "This Email #{@user.email} has already been taken. Please enter a new email"
            format.html { render :signup }
          end
      	end
    end
  end

  def password_reset
  end 

  def reset_notice
    case request.method
      when "POST"
      respond_to do |format|
        @user = User.find_by_email(params[:email])
        if params[:email].blank?
          flash.now[:notice] = 'Email Field Cannot Be Empty.'
          format.html { render :password_reset }
        elsif @user.nil?
          flash[:notice] = 'Sorry. Email does not exist. It may be because you do not have an account with us yet.
                            Please sign up now.'
          format.html { redirect_to account_login_path }
        elsif @user and @user.active?
          @user.send_password_reset
          flash[:notice] = "A Reset link has been sent to your email #{@user.email}.
                            Please click on it to finish resetting your password. Thank you."
          format.html { redirect_to account_login_path }
        else
          flash[:resend] = 'Your account has not been activated yet. Please check your email inbox to look
                            for the activation link. If you have not received your activation link yet,
                            click on this link to'
          format.html { redirect_to account_login_path }
        end
      end
    end
  end

  def reset_approved
    case request.method
      when "POST"
        respond_to do |format|
          @user = User.find_by_auth_token(params[:auth_token])
          if @user.update_attributes(user_params)
            flash[:notice] = 'Your Password has been Successfully reset.'
            format.html { redirect_to account_login_path }
          else
            flash[:notice] = 'Something went wrong.Please reset your password again.'
            format.html { render :reset_approved }
          end
        end
    end
  end 

  def activate
    respond_to do |format|
      @user.update_attributes(:active => true) unless @user.active?
      flash[:notice] = 'Your Account has been activated. Please Log In.'
      format.html { redirect_to account_login_path }
    end
  end

  def resend_activation
    case request.method
      when "POST"
        respond_to do |format|
          @user = User.find_by_email(params[:email])
          EmailSenderJob.perform_later(@user)
          flash.now[:resend] = 'Account activation link has been resent. Please check your email inbox.
                                If you have not received it yet for some reason, click to'
          format.html { render :login}
        end
    end
  end

  def login
  	case request.method
  	  when "POST"
  	  	respond_to do |format|
  	  	  @user = User.find_by_login(params[:login])

  	  	  if authorized_user?(@user, params[:password]) && @user.active?
            if params[:remember_me]
              cookies.permanent[:user_id] = @user.id
            else
              cookies[:user_id] = @user.id
            end
  	  	  	format.html {  redirect_to user_devices_path(@user) }
          elsif authorized_user?(@user, params[:password]) && @user.active.nil?
            flash[:resend] = 'Your account has not been activated yet. Please check your email inbox to look
                              for the activation link. If you have not received your activation link yet,
                              click on this link to'
            format.html { redirect_to account_login_path }
  	  	  else
  	  	  	flash[:error] = 'Warning! Invalid Username/Password.'
            format.html { redirect_to account_login_path }
          end
        end
  	end
  end

  def logout
  	respond_to do |format|
  	  cookies.delete(:user_id)
  	  flash[:notice] = 'User Successfully Logged Out'
  	  format.html { redirect_to account_login_path }
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def authorized_user?(user, pass)
    return true if user && user.authenticate(pass)
  end

  def check_token_expiration
    @user = User.find_by_auth_token(params[:auth_token])
    if @user.token_expired?
      flash[:notice] = 'Your Password Reset request has been expired.'
      redirect_to account_login_path
      return false
    else
      return true
    end
  end

end