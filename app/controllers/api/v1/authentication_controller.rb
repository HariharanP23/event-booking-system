class Api::V1::AuthenticationController < ApplicationController
  def login_organizer
    @organizer = EventOrganizer.find_by(email: params[:email])

    if @organizer&.authenticate(params[:password])
      @access_token = generate_access_token(@organizer)
      @refresh_token = generate_refresh_token(@organizer)
      render :login
    else
      render_error 'Invalid email or password', status: :unauthorized
    end
  end
  
  def login_customer
    @customer = Customer.find_by(email: params[:email])
    
    if @customer&.authenticate(params[:password])
      @access_token = generate_access_token(@customer)
      @refresh_token = generate_refresh_token(@customer)
      render :login
    else
      render_error 'Invalid email or password', status: :unauthorized
    end
  end
  
  private

  def generate_access_token(user)
    JWT.encode({ user_id: user.id, exp: Time.now.to_i + (30 * 60) }, ENV.fetch("ACCESS_TOKEN_SECRET", "sdf"), "HS256")
  end

  def generate_refresh_token(user)
    JWT.encode({ user_id: user.id }, ENV["REFRESH_TOKEN_SECRET"], "HS256")
  end
end
