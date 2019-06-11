class AddEnergiesAccordid < ActiveRecord::Migration[5.2]
  def change
  	add_column :energies, :accord_id, :integer
  end
end
