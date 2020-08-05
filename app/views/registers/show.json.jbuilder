json.extract! @register, :id, :created_at, :updated_at
json.url register_url(@register, format: :json)
