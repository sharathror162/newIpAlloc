class User < ApplicationRecord

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true

  has_secure_password

end