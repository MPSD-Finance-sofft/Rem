class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :text
      t.string :object
      t.integer :object_id
      t.integer :user_id
      t.boolean :active

      t.timestamps
    end
  end
end
