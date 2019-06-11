json.extract! expense, :id, :date_of_excepted_payment, :payout_day, :description, :accord_id, :amount, :real_amount, :expense_type_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
