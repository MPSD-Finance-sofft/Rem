class CreateTerrains < ActiveRecord::Migration[5.2]
  def change
    create_table :terrains do |t|
      t.integer :accord_id
      t.integer :user_id
      t.integer :agent_id
      t.date :date_meeting_in_terain
      t.date :date_to_terrain
      t.date :date_end_terrain

      t.timestamps
    end
  end
end
