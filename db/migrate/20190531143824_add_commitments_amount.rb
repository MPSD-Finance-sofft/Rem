class AddCommitmentsAmount < ActiveRecord::Migration[5.2]
  def change
  	add_column :commitments, :amount, :decimal
  end
end
