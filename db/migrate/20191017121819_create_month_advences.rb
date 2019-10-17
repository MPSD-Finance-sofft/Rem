class CreateMonthAdvences < ActiveRecord::Migration[5.2]
  def change
    create_table :month_advences do |t|
      t.integer :accord_id
      t.decimal :price
      t.date :date_due
      t.date :date_of_payment

      t.timestamps
    end
  end
end
