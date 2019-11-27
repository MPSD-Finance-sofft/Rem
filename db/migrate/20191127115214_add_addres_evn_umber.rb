class AddAddresEvnUmber < ActiveRecord::Migration[5.2]
  def change
  	add_column :addresses, :ev_number, :string
  end
end
