class AddAddressToRealty < ActiveRecord::Migration[5.2]
  def change
  	add_column :realties, :address_id, :integer
  end
end
