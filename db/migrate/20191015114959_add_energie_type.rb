class AddEnergieType < ActiveRecord::Migration[5.2]
  def change
  	add_column :energies, :type, :string
  end
end
