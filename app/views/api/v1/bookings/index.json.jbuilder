json.partial! 'api/v1/shared/pagination', pagination: @pagination if @pagination

json.data do
  json.array! @bookings do |booking|
    json.partial! 'api/v1/bookings/booking', booking: booking
  end
end