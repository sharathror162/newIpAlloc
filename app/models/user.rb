require 'digest/sha1'

class User < ApplicationRecord

  validates :login, :email, presence: true, uniqueness: true

  before_save :sha1_pass

#For Login
  def self.authenticate(login, password)
  	self.find_by_login_and_password(login, Digest::SHA1.hexdigest(password))
  end

#For Signup
  def sha1_pass
  	self.password = Digest::SHA1.hexdigest(self.password)
  end
 
end