class PasswordResetRequestJob < ApplicationJob
  queue_as :high_priority

  def perform(user)
    AccountMailer.password_reset_notice(user).deliver_now
  end
end
