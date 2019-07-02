class ChangeDelivaryDateInvoiceFormat < ActiveRecord::Migration[5.2]
  def change
  	change_column :invoices, :delivery_date, :date
  end
end
