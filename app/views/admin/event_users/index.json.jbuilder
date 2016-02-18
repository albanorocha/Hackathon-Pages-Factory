json.array!([:admin, @event_users]) do |event_user|
  json.extract! event_user, :id
  json.url event_user_url(event_user, format: :json)
end
