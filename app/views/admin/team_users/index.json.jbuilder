json.array!(@admin_team_users) do |admin_team_user|
  json.extract! admin_team_user, :id
  json.url admin_team_user_url(admin_team_user, format: :json)
end
