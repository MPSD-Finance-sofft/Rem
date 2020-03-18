class CreateSalesContractRealties < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_contract_realties do |t|
      t.integer :sales_contract_id
      t.integer :realty_id

      t.timestamps
    end
  end
end
