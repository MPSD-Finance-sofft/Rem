class RemoveTerrainOnAccord < ActiveRecord::Migration[5.2]
  def change
  	remove_column :accords, :agent_terrain_id
  	remove_column :accords, :date_to_terrain
  	remove_column :accords, :date_meeting_in_terain
  end
end
