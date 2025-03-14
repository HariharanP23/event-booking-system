class Event < ApplicationRecord
  belongs_to :event_organizer

  has_many :tickets, dependent: :destroy
  has_many :customers, through: :bookings
  
  validates :title, presence: true
  validates :date, presence: true
  validates :venue, presence: true
end
