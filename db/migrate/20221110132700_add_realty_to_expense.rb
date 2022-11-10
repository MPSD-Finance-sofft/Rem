class AddRealtyToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :realty_id, :integer
  end
end
