class AddLeasigContractKind < ActiveRecord::Migration[5.2]
  def change
	add_column :leasing_contracts, :kind, :integer
  end
end
