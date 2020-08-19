class AddAgentiDtolEasingContract < ActiveRecord::Migration[5.2]
  def change
    add_column :leasing_contracts, :agent_id, :integer
  end
end

