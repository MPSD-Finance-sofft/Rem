class CreateSalesContractClients < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_contract_clients do |t|
      t.integer :sales_contract_id
      t.integer :client_id
      t.integer :relationship

      t.timestamps
    end
  end
end
