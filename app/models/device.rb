class Device < ApplicationRecord

  has_many :ip_addresses, dependent: :destroy
  validates :name, presence: true, uniqueness: true

end
