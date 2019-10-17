class CreateTaxReturns < ActiveRecord::Migration[5.2]
  def change
    create_table :tax_returns do |t|
      t.date :date_send
      t.decimal :price
      t.date :date_send_tax_office
      t.date :tax_pay_date
      t.string :number
      t.integer :accord_id

      t.timestamps
    end
  end
end
