class CreateSalesContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_contracts do |t|
      t.integer :accord_id
      t.date :date_of_sale_realty
      t.decimal :amount
      t.decimal :date_of_receipt_of_payment
      t.integer :user_id
      t.integer :sate
      t.integer :kind

      t.timestamps
    end
  end
end
