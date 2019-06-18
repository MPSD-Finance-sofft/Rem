class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.date :payment_date
      t.integer :leasing_contract_id

      t.timestamps
    end
  end
end
