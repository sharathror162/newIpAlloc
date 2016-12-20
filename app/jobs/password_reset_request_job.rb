class PasswordResetRequestJob < ApplicationJob
  queue_as :default

  def perform(user)
    AccountMailer.password_reset_notice(user).deliver_now
  end
end
