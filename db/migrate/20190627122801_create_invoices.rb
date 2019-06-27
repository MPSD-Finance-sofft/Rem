class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.date :payout_date
      t.string :delivery_date
      t.integer :period_year
      t.integer :period_month

      t.timestamps
    end
  end
end
