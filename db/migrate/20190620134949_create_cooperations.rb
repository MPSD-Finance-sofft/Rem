class CreateCooperations < ActiveRecord::Migration[5.2]
  def change
    create_table :cooperations do |t|
      t.integer :agent_id
      t.date :date_of_notice
      t.integer :day_count
      t.integer :type_of_notice_id
      t.integer :user_id
      t.integer :or_request_id
      t.text :notice

      t.timestamps
    end
  end
end
