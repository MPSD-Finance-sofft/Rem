class AddDataToEvent < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :creator_id, :integer
  	add_column :events, :done, :boolean
  	add_column :events, :localite, :text
  	add_column :events, :text, :text
  end
end
