class Customer < ApplicationRecord
  has_secure_password

  has_many :events, through: :bookings
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
