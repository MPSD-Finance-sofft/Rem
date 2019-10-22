class ClientAddRealationShip < ActiveRecord::Migration[5.2]
  def change
  	add_column :clients, :relation_ship, :string
  end
end
