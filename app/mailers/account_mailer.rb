class AccountMailer < ApplicationMailer

  default from: 'notifications@example.com'
 
  def activation_notice(user)
    @user = user
    @activation_link  = "http://localhost:3000/account/activate/#{@user.id}"
    mail(to: @user.email, subject: 'Activate Your Account')
  end

  def password_reset_notice(user)
  	@user_reset = user
  	@reset_link  = "http://localhost:3000/account/reset_approved/#{@user_reset.id}"
    mail(to: @user_reset.email, subject: 'Reset Your Password')
  end

end
