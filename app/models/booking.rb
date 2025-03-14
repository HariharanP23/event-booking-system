class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :event
  has_many :booking_tickets, dependent: :destroy
  has_many :tickets, through: :booking_tickets
  
  validates :booking_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending confirmed cancelled] }

  def calculate_total_price
    booking_tickets.sum { |bt| bt.ticket.price * bt.quantity }
  end
end
