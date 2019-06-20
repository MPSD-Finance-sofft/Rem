class AccordAddPurchasePrice < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :purchase_price, :decimal
  end
end
