class AddClientKind < ActiveRecord::Migration[5.2]
  def change 
  	add_column :clients, :kind, :integer
  end
end
