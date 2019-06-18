class CreateRepayments < ActiveRecord::Migration[5.2]
  def change
    create_table :repayments do |t|
      t.decimal :amount
      t.date :repayment_date
      t.integer :leasing_contract_id

      t.timestamps
    end
  end
end
