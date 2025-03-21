json.partial! 'api/v1/shared/pagination', pagination: @pagination if @pagination

json.data do
  json.array! @events do |event|
    json.partial! 'api/v1/events/event', event: event
  end
end