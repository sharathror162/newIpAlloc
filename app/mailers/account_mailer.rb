class AccountMailer < ApplicationMailer

  default from: 'notifications@example.com'
 
  def activation_notice(user)
    @user = user
    @activation_link  = "http://localhost:3000/account/activate/#{@user.id}"
    mail(to: @user.email, subject: 'Activate Your Account')
  end

  def password_reset_notice(user)
  	@user = user
  	@reset_link  = "http://localhost:3000/account/reset_approved/#{@user.auth_token}"
    mail(to: @user.email, subject: 'Reset Your Password')
  end

end
