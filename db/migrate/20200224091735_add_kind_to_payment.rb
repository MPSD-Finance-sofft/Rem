class AddKindToPayment < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :kind, :integer
  end
end
