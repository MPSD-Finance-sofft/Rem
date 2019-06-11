class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.date :date_of_excepted_payment
      t.date :payout_day
      t.text :description
      t.integer :accord_id
      t.decimal :amount
      t.decimal :real_amount
      t.integer :expense_type_id

      t.timestamps
    end
  end
end
