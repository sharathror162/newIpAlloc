class User < ApplicationRecord

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A\w+\.\w+@gmail.com\z/}

  has_secure_password
  has_many :devices, dependent: :destroy

end