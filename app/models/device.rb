class Device < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :ip_addresses, dependent: :destroy
  belongs_to :user

end
