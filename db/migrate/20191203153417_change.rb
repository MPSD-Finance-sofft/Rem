class Change < ActiveRecord::Migration[5.2]
  def change
  	change_column :commitments, :amount, :float
  	change_column :commitments, :real_amount, :float
  	change_column :expenses, :real_amount, :float
  	change_column :expenses, :real_amount, :float
  end
end
