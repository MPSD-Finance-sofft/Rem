class CreateInsurances < ActiveRecord::Migration[5.2]
  def change
    create_table :insurances do |t|
      t.integer :accord_id
      t.date :date_start
      t.date :date_send
      t.decimal :price
      t.decimal :date_of_payment

      t.timestamps
    end
  end
end
