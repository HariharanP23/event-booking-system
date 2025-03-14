class CreateBookingTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :booking_tickets do |t|
      t.integer :quantity
      t.references :booking, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
