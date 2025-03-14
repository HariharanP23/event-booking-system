class BookingTicket < ApplicationRecord
  belongs_to :booking
  belongs_to :ticket

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
