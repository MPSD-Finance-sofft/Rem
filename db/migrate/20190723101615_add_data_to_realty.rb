class AddDataToRealty < ActiveRecord::Migration[5.2]
  def change
  	add_column :realties, :flat_number, :integer
  	add_column :realties, :disposition_id, :integer
  	add_column :realties, :real_number_abovegroud_floors, :integer
  	add_column :realties, :part_number, :string
  end
end
