class AddAccordDateToTerrain < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :date_to_terrain, :date
  end
end
