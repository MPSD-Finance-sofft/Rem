class CreateSalesContractAccord < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_contract_accords do |t|
      t.references :accord, foreign_key: true
      t.references :sales_contract, foreign_key: true
      t.timestamps
    end
  end
end
