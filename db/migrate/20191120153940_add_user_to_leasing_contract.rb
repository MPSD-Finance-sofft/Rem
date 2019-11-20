class AddUserToLeasingContract < ActiveRecord::Migration[5.2]
  def change
  	add_column :leasing_contracts, :user_id, :integer
  end
end
