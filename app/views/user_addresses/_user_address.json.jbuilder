json.extract! user_address, :id, :user_id, :address_id, :kind, :created_at, :updated_at
json.url user_address_url(user_address, format: :json)
