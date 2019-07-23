class CreateLeasingContractRealties < ActiveRecord::Migration[5.2]
  def change
    create_table :leasing_contract_realties do |t|
      t.integer :leasing_contract_id
      t.integer :realty_id

      t.timestamps
    end
  end
end
