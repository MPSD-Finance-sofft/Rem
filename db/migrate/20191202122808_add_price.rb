class AddPrice < ActiveRecord::Migration[5.2]
  def change
  	add_column :planned_prices, :real_price, :decimal
  end
end
