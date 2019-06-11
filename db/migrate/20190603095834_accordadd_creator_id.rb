class AccordaddCreatorId < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :creator_id, :integer
  end
end
