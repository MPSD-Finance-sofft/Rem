class CreateLeasingContractClients < ActiveRecord::Migration[5.2]
  def change
    create_table :leasing_contract_clients do |t|
      t.integer :leasing_contract_id
      t.integer :relationship
      t.integer :client_id

      t.timestamps
    end
  end
end
