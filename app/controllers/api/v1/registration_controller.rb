class Api::V1::RegistrationController < ApplicationController
  def register_organizer
    @organizer = EventOrganizer.new(organizer_params)
    
    if @organizer.save
      render_success "created Successfully"
    else
      render_error @organizer.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def register_customer
    @customer = Customer.new(customer_params)
    
    if @customer.save
      render_success "created Successfully"
    else
      render_error @customer.errors.full_messages status: :unprocessable_entity
    end
  end
  
  private
  
  def organizer_params
    params.permit(:name, :email, :password, :password_confirmation, :description, :contact_number)
  end
  
  def customer_params
    params.permit(:name, :email, :password, :password_confirmation, :address, :contact_number)
  end
end