json.extract! @user, :id, :all_name, :created_at, :updated_at
json.url expense_type_url(@user, format: :json)