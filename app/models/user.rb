class User < ApplicationRecord

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true
  has_secure_password

  has_many :devices, dependent: :destroy

  def send_password_reset
    generate_token(:auth_token)
    self.token_expiration = Time.zone.now
    save!
    PasswordResetRequestJob.perform_later(self)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def token_expired?
    token_expiration <= 30.minutes.ago ? true : false
  end

end