json.extract! invoice, :id, :payout_date, :delivery_date, :period_year, :period_month, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
