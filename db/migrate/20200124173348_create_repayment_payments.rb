class CreateRepaymentPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :repayment_payments do |t|
      t.integer :repayment_id
      t.integer :payment_id
      t.float :amount

      t.timestamps
    end
  end
end
