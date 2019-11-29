class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.integer :creator_id
      t.integer :user_id
      t.integer :object_id
      t.string :object
      t.text :text
      t.integer :alert_type_id
      t.boolean :done
      t.date :date_alert

      t.timestamps
    end
  end
end
