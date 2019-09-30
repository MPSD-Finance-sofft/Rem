class AddAcordIdtoLisingContract < ActiveRecord::Migration[5.2]
  def change
  	add_column :leasing_contracts, :accord_id, :integer
  end
end
