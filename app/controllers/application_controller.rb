class ApplicationController < ActionController::API

  private

  def current_event_organizer
    payload = JWT.decode(request.headers["Authorization"].split(" ").last, ENV.fetch("ACCESS_TOKEN_SECRET", "sdf"), true, { algorithm: "HS256" })
    @current_event_organizer = EventOrganizer.find_by(id: payload[0]["user_id"])
  rescue JWT::ExpiredSignature
    render_error("Access token expired", 401)
  rescue JWT::DecodeError
    render_error("Invalid access token", 401)
  end

  def current_customer_user
    payload = JWT.decode(request.headers["Authorization"].split(" ").last, ENV.fetch("ACCESS_TOKEN_SECRET", "sdf"), true, { algorithm: "HS256" })
    @current_customer_user = Customer.find_by(id: payload[0]["user_id"])
  rescue JWT::ExpiredSignature
    render_error("Access token expired", 401)
  rescue JWT::DecodeError
    render_error("Invalid access token", 401)
  end

  def render_success(message, data = {}, status = :ok)
    render json: { success: true, message: }.merge(data), status:
  end

  def render_error(_exception = nil, errors, status)
    render json: { errors: Array.wrap(errors) }, status:
  end
end
