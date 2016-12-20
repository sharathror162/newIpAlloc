class User < ApplicationRecord

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true
  validates :legacy_code, format: { with: /\A[a-zA-Z0-9]+@gmail.com\z/ }

  has_secure_password

end