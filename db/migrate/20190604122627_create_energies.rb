class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :kind
      t.date :date_of
      t.integer :distributor_id
      t.decimal :price
      t.date :payment_day

      t.timestamps
    end
  end
end
