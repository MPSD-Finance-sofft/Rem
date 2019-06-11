class AccordaddNumber < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :number, :integer,  :limit => 8
  end
end
