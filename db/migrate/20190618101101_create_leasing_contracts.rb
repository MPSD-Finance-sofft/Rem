class CreateLeasingContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :leasing_contracts do |t|
      t.integer :state
      t.date :expected_date_of_signature
      t.date :rent_from
      t.date :rent_to
      t.integer :payment_day
      t.decimal :monthly_rent

      t.timestamps
    end
  end
end
