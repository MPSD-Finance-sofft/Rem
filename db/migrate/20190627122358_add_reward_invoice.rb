class AddRewardInvoice < ActiveRecord::Migration[5.2]
  def change
  	add_column :rewards, :invoice_id, :integer
  	remove_column :rewards, :invoice_date
  	remove_column :rewards, :payout_date
  end
end
