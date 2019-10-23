class AccordChangeType < ActiveRecord::Migration[5.2]
  def change
  	change_column :realties, :real_number_abovegroud_floors, :string
  	add_column :accords, :excepted_date_of_transfer, :date
  	add_column :realties, :date_of_final_building_approval, :date
  end
end
