class AddAgentNote < ActiveRecord::Migration[5.2]
  def change
    create_table :agent_notes do |t|
      t.integer :user_id
      t.integer :creator_id
      t.text    :text
      t.timestamps
    end
  end
end
