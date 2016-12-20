class EmailSenderJob < ApplicationJob
  queue_as :high_priority

  def perform(user)
    AccountMailer.activation_notice(user).deliver_now
  end

end
