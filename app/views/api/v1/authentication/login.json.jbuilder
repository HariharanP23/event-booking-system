json.data do
    json.id @organizer&.id || @customer&.id
    json.name @organizer&.name || @customer&.name
    json.email @organizer&.email || @customer&.email
    json.contact_number @organizer&.contact_number || @customer&.contact_number
    json.access_token @access_token
    json.refresh_token @refresh_token
    json.expires_in 15.minutes.from_now.to_i
end