json.extract! payment, :id, :amount, :payment_date, :leasing_contract_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
