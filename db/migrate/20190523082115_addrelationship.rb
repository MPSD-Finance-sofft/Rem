class Addrelationship < ActiveRecord::Migration[5.2]
  def change 
  	add_column :accords_clients, :relationship, :integer
  end
end
