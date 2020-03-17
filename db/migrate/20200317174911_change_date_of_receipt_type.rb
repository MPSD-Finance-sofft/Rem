class ChangeDateOfReceiptType < ActiveRecord::Migration[5.2]
  def change
    change_column :sales_contracts, :date_of_receipt_of_payment, :date
  end
end
