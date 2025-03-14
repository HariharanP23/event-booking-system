class Api::V1::BookingsController < ApplicationController
    before_action :current_customer_user
    before_action :set_booking, only: [:show, :update]
    
    def index
      bookings = @current_customer_user.bookings
      @pagy, @bookings = pagy(bookings)
      @pagination = pagy_metadata(@pagy)
    end
    
    def show; end
    
    def create
      unless @current_customer_user
        return render_error 'Only customers can create bookings', status: :forbidden
      end
      
      @event = Event.find(params[:event_id])
      @booking = @current_customer_user.bookings.build(
        event: @event,
        booking_date: Time.current,
        total_price: 0,
        status: 'pending'
      )
      
      if @booking.save && process_booking_tickets
        @booking.update(total_price: @booking.calculate_total_price, status: 'confirmed')
        render_success "created Successfully"
      else
        @booking.destroy if @booking.persisted?
        render_error @booking.errors.full_messages, status: :unprocessable_entity
      end
    end
    
    def update      
      if @booking.update(status: params[:status])
        render_success "Updated Successfully"
      else
        render_error @booking.errors.full_messages, status: :unprocessable_entity
      end
    end
    
    private
    
    def set_booking
      @booking = Booking.find(params[:id])
    end
    
    def process_booking_tickets
      return false unless params[:tickets].present?
      
      success = true
      
      ActiveRecord::Base.transaction do
        params[:tickets].each do |ticket_params|
          ticket = @event.tickets.find(ticket_params[:id])
          booking_ticket = @booking.booking_tickets.build(
            ticket: ticket,
            quantity: ticket_params[:quantity]
          )
          
          unless booking_ticket.save
            success = false
            raise ActiveRecord::Rollback
          end
        end
      end
      
      success
    end
  end