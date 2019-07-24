class AccordAgentTerain < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :agent_terrain_id, :integer
  end
end
