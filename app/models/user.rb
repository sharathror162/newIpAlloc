require 'digest/sha1'

class User < ApplicationRecord

  validates :login, :email, presence: true, uniqueness: true

  attr_accessor :hashed_password

  before_save :sha1_pass

  def self.authenticate(login, password)
  	self.find_by_login_and_password(login, Digest::SHA1.hexdigest(password))
  end

  def sha1_pass
  	self.hashed_password = Digest::SHA1.hexdigest(self.password)
  	self.password = hashed_password
  end

end
