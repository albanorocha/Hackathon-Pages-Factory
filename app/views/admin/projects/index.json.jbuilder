json.array!(@admin_projects) do |admin_project|
  json.extract! admin_project, :id
  json.url admin_project_url(admin_project, format: :json)
end
