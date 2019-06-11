class AddAccordData < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :contract_number, :integer, limit: 8
  	add_column :accords, :date_of_signature, :date
  	add_column :accords, :date_of_ownership, :date
  	add_column :accords, :date_of_transfer, :date
  	add_column :accords, :transfer_protocol, :integer
  	add_column :accords, :address_id, :integer
  end
end
