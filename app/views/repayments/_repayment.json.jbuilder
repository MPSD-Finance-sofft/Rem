json.extract! repayment, :id, :amount, :repayment_date, :leasing_contract_id, :created_at, :updated_at
json.url repayment_url(repayment, format: :json)
