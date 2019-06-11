class AddCommitmentsRealAmount < ActiveRecord::Migration[5.2]
   def change
  	add_column :commitments, :real_amount, :decimal
  end
end
