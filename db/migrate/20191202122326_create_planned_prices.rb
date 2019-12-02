class CreatePlannedPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :planned_prices do |t|
      t.integer :accord_id
      t.integer :user_id
      t.decimal :advertising_price
      t.decimal :market_price
      t.decimal :estimated_selling_price

      t.timestamps
    end
  end
end
