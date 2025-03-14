class Api::V1::TicketsController < ApplicationController
  before_action :current_event_organizer, except: [:index, :show]
  before_action :set_event
  before_action :set_ticket, only: [:show, :update, :destroy]
    
  def index
    @tickets = @event.tickets
  end
    
  def show; end
    
  def create
    @ticket = @event.tickets.build(ticket_params)
      
    if @ticket.save
      render_success "Created Successfully"
    else
      render_error @ticket.errors.full_messages, status: :unprocessable_entity
    end
  end
    
  def update      
    if @ticket.update(ticket_params)
      render_success "Updated Successfully"
    else
      render_error @ticket.errors.full_messages, status: :unprocessable_entity
    end
  end
    
  def destroy      
    @ticket.destroy
    render_success "Deleted Successfully"
  end
    
  private
    
  def set_event
    @event = Event.find(params[:event_id])
  end
    
  def set_ticket
    @ticket = @event.tickets.find(params[:id])
  end
    
  def ticket_params
    params.require(:ticket).permit(:category, :price, :quantity)
  end
end