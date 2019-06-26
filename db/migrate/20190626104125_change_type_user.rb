class ChangeTypeUser < ActiveRecord::Migration[5.2]
  def change
	change_column :users, :bank_code, :string
	remove_column :users, :billing_address_id
	remove_column :users, :malling_address_id
  end
end
