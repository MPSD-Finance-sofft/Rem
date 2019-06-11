class AddAccordAgentId < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :agent_id, :integer
  end
end
