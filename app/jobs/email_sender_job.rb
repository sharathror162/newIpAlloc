class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform(user)
    AccountMailer.activation_notice(user).deliver_now
  end
end
