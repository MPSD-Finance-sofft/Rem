class AddAccordAgentInSignature < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :agent_in_signature_id, :integer
  end
end
