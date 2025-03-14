class Api::V1::EventsController < ApplicationController
  before_action :current_event_organizer, except: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    events = Event.all
    @pagy, @events = pagy(events)
    @pagination = pagy_metadata(@pagy)
  end

  def show; end

  def create        
    @event = @current_event_organizer.events.build(event_params)
    
    if @event.save
      render_success "created Successfully"
    else
      render_error @event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update    
    if @event.update(event_params)
      render_success "Updated Successfully"
    else
      render_error @event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy    
    @event.destroy
    render_success "Deleted Successfully"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :venue, :capacity)
  end
end
