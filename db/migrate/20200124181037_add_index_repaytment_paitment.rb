class AddIndexRepaytmentPaitment < ActiveRecord::Migration[5.2]
  def change
  	add_index :repayment_payments, :repayment_id
  	add_index :repayment_payments, :payment_id
  end
end
