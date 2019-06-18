json.extract! leasing_contract, :id, :state, :expected_date_of_signature, :rent_from, :rent_to, :payment_day, :monthly_rent, :created_at, :updated_at
json.url leasing_contract_url(leasing_contract, format: :json)
