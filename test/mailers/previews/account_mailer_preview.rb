# Preview all emails at http://localhost:3000/rails/mailers/account_mailer
class AccountMailerPreview < ActionMailer::Preview

  def activation_notice(user)
    @user = user
    @activation_link  = "http://localhost:3000/account/activate/#{@user.id}"
    mail(to: @user.email, subject: 'Activate Your Account')
  end


end
