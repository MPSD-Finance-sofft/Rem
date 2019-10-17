class CreatePenbs < ActiveRecord::Migration[5.2]
  def change
    create_table :penbs do |t|
      t.integer :accord_id
      t.decimal :price
      t.integer :energy_class
      t.date :delivery_date
      t.date :date_of_delivery_request

      t.timestamps
    end
  end
end
