json.array!(@events) do |event|
  json.extract! event, :id, :descriptor, :name, :date, :address, :description, :image, :release_sign_up, :published
  json.url event_url(event, format: :json)
end
