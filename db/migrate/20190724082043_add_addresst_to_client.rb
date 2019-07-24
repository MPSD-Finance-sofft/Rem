class AddAddresstToClient < ActiveRecord::Migration[5.2]
  def change
  	add_column :clients, :permanent_address_id, :integer
  	add_column :clients, :contact_address_id, :integer
  end
end
