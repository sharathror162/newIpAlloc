class IpAddress < ApplicationRecord

  belongs_to :device
  validates :ip_value, presence: true, uniqueness: true
  validates :ip_value, format: { with: /\A1.2+\.[0-9]{1,3}+\.[0-9]{1,3}\z/ }

end
